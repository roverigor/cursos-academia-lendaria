"""
MMOS v5.0 - Model Optimization Service
Multi-model processing and sweet spot discovery
"""

import asyncio
import json
import hashlib
from datetime import datetime, timedelta
from typing import Dict, List, Optional, Tuple
from dataclasses import dataclass
from enum import Enum
import asyncpg
import numpy as np
from litellm import acompletion  # Universal LLM interface


# Configuration
@dataclass
class ModelConfig:
    """Model configuration with cost and performance characteristics"""
    provider: str
    name: str
    cost_per_1k_input: float
    cost_per_1k_output: float
    quality_baseline: float  # Expected quality 0-10
    speed_factor: float  # Relative speed (1.0 = baseline)
    temperature: float = 0.7
    max_tokens: int = 4096


class ProcessingStatus(Enum):
    PENDING = "pending"
    PROCESSING = "processing"
    COMPLETED = "completed"
    FAILED = "failed"


# Model configurations (actual pricing as of 2025)
MODELS = {
    "gpt-4": ModelConfig(
        provider="openai",
        name="gpt-4",
        cost_per_1k_input=0.03,
        cost_per_1k_output=0.06,
        quality_baseline=9.0,
        speed_factor=1.0
    ),
    "gpt-3.5-turbo": ModelConfig(
        provider="openai",
        name="gpt-3.5-turbo",
        cost_per_1k_input=0.0005,
        cost_per_1k_output=0.0015,
        quality_baseline=7.0,
        speed_factor=2.0
    ),
    "claude-3-opus": ModelConfig(
        provider="anthropic",
        name="claude-3-opus",
        cost_per_1k_input=0.015,
        cost_per_1k_output=0.075,
        quality_baseline=9.5,
        speed_factor=0.8
    ),
    "claude-3-sonnet": ModelConfig(
        provider="anthropic",
        name="claude-3-sonnet",
        cost_per_1k_input=0.003,
        cost_per_1k_output=0.015,
        quality_baseline=8.5,
        speed_factor=1.5
    ),
    "gemini-pro": ModelConfig(
        provider="google",
        name="gemini-pro",
        cost_per_1k_input=0.001,
        cost_per_1k_output=0.002,
        quality_baseline=8.0,
        speed_factor=1.8
    )
}


class FragmentExtractor:
    """Extract fragments using different models"""
    
    def __init__(self, db_pool: asyncpg.Pool):
        self.db = db_pool
        self.extraction_prompt = self._load_extraction_prompt()
    
    def _load_extraction_prompt(self) -> str:
        """Load the MIU-compliant extraction prompt"""
        return """
        Extract psychological fragments from this content following MIU principles.
        Each fragment must be:
        1. COMPLETE and SELF-CONTAINED (all references resolved)
        2. Preserve causal/temporal relationships
        3. Split at contrasts and topic changes
        
        Return JSON array of fragments with:
        - content: The exact text (MIU-compliant)
        - category: Biographical/Cognitive/Behavioral/etc
        - type: direct_quote/paraphrase/pattern/etc
        - context: Situational context
        - insight: Key psychological insight
        - relevance: 1-10 score
        - confidence: 0.0-1.0 confidence
        - tags: Array of relevant tags
        """
    
    async def extract_fragments(
        self,
        source_id: int,
        content: str,
        model_config: ModelConfig
    ) -> Tuple[List[Dict], Dict[str, any]]:
        """Extract fragments using specified model"""
        
        start_time = datetime.now()
        
        # Prepare messages
        messages = [
            {"role": "system", "content": self.extraction_prompt},
            {"role": "user", "content": f"Extract fragments from:\n\n{content}"}
        ]
        
        # Call model through unified interface
        response = await acompletion(
            model=f"{model_config.provider}/{model_config.name}",
            messages=messages,
            temperature=model_config.temperature,
            max_tokens=model_config.max_tokens,
            response_format={"type": "json_object"}
        )
        
        # Parse response
        fragments = json.loads(response.choices[0].message.content)["fragments"]
        
        # Calculate metrics
        end_time = datetime.now()
        processing_time = (end_time - start_time).total_seconds()
        
        # Token usage
        input_tokens = response.usage.prompt_tokens
        output_tokens = response.usage.completion_tokens
        
        # Cost calculation
        cost = (
            (input_tokens / 1000) * model_config.cost_per_1k_input +
            (output_tokens / 1000) * model_config.cost_per_1k_output
        )
        
        metrics = {
            "processing_time": processing_time,
            "input_tokens": input_tokens,
            "output_tokens": output_tokens,
            "cost": cost,
            "fragments_count": len(fragments)
        }
        
        return fragments, metrics


class ModelOptimizer:
    """Find optimal model for different source types"""
    
    def __init__(self, db_pool: asyncpg.Pool):
        self.db = db_pool
        self.extractor = FragmentExtractor(db_pool)
    
    async def process_with_multiple_models(
        self,
        source_id: int,
        content: str,
        models_to_test: List[str]
    ) -> Dict[str, any]:
        """Process same source with multiple models for comparison"""
        
        results = {}
        
        for model_name in models_to_test:
            model_config = MODELS[model_name]
            
            # Create batch
            batch_id = await self._create_batch(model_config)
            
            try:
                # Extract fragments
                fragments, metrics = await self.extractor.extract_fragments(
                    source_id, content, model_config
                )
                
                # Save to database
                await self._save_fragments(
                    fragments, source_id, batch_id
                )
                
                # Update batch statistics
                await self._update_batch_stats(batch_id, metrics)
                
                # Calculate quality score
                quality_score = await self._calculate_quality_score(
                    fragments
                )
                
                results[model_name] = {
                    "batch_id": batch_id,
                    "fragments_count": len(fragments),
                    "quality_score": quality_score,
                    "cost": metrics["cost"],
                    "processing_time": metrics["processing_time"],
                    "cost_per_fragment": metrics["cost"] / len(fragments) if fragments else 0
                }
                
            except Exception as e:
                results[model_name] = {
                    "error": str(e),
                    "batch_id": batch_id
                }
                await self._mark_batch_failed(batch_id, str(e))
        
        return results
    
    async def find_sweet_spot(
        self,
        source_id: int,
        content_sample: str,
        quality_threshold: float = 7.0,
        budget_per_fragment: float = 0.05
    ) -> str:
        """Find cheapest model that meets quality threshold"""
        
        # Test models in order of increasing cost
        models_by_cost = sorted(
            MODELS.items(),
            key=lambda x: x[1].cost_per_1k_output
        )
        
        best_model = None
        best_ratio = 0
        
        for model_name, config in models_by_cost:
            # Process sample
            fragments, metrics = await self.extractor.extract_fragments(
                source_id, content_sample, config
            )
            
            # Calculate quality
            quality = await self._calculate_quality_score(fragments)
            
            # Check if meets threshold
            if quality >= quality_threshold:
                cost_per_frag = metrics["cost"] / len(fragments) if fragments else float('inf')
                
                # Check budget constraint
                if cost_per_frag <= budget_per_fragment:
                    # Calculate quality/cost ratio
                    ratio = quality / cost_per_frag if cost_per_frag > 0 else 0
                    
                    if ratio > best_ratio:
                        best_model = model_name
                        best_ratio = ratio
        
        return best_model or "gpt-4"  # Default to best if none meet criteria
    
    async def progressive_optimization(
        self,
        source_id: int
    ) -> Dict[str, any]:
        """Progressive model optimization strategy"""
        
        # Get source details
        source = await self.db.fetchrow(
            "SELECT * FROM sources WHERE id = $1",
            source_id
        )
        
        # Determine testing strategy based on source type
        if source["quality"] == "primary" and source["source_type"] in ["interview", "book"]:
            # High-value content - test quality models
            models_to_test = ["gpt-4", "claude-3-opus", "claude-3-sonnet"]
        elif source["quality"] == "secondary":
            # Medium-value content
            models_to_test = ["claude-3-sonnet", "gemini-pro", "gpt-3.5-turbo"]
        else:
            # Low-value content - focus on cheap models
            models_to_test = ["gpt-3.5-turbo", "gemini-pro"]
        
        # Get sample content
        content_sample = await self._get_content_sample(source_id, 2000)
        
        # Test each model
        results = await self.process_with_multiple_models(
            source_id, content_sample, models_to_test
        )
        
        # Find optimal model
        optimal = self._select_optimal_model(results)
        
        # Save recommendation
        await self._save_optimization_result(source_id, optimal, results)
        
        return {
            "source_id": source_id,
            "optimal_model": optimal,
            "test_results": results,
            "recommendation": self._generate_recommendation(optimal, results)
        }
    
    def _select_optimal_model(self, results: Dict) -> str:
        """Select optimal model based on results"""
        
        valid_results = {
            k: v for k, v in results.items()
            if "error" not in v and v["quality_score"] >= 7.0
        }
        
        if not valid_results:
            return "gpt-4"  # Default to best
        
        # Sort by quality/cost ratio
        sorted_models = sorted(
            valid_results.items(),
            key=lambda x: x[1]["quality_score"] / x[1]["cost_per_fragment"],
            reverse=True
        )
        
        return sorted_models[0][0]
    
    def _generate_recommendation(self, optimal: str, results: Dict) -> str:
        """Generate human-readable recommendation"""
        
        if optimal not in results:
            return "Unable to determine optimal model"
        
        opt_result = results[optimal]
        
        # Calculate savings vs GPT-4
        if "gpt-4" in results and optimal != "gpt-4":
            gpt4_cost = results["gpt-4"]["cost_per_fragment"]
            savings = (gpt4_cost - opt_result["cost_per_fragment"]) / gpt4_cost * 100
            
            return (
                f"Recommended: {optimal}\n"
                f"Quality: {opt_result['quality_score']:.1f}/10\n"
                f"Cost: ${opt_result['cost_per_fragment']:.4f}/fragment\n"
                f"Savings vs GPT-4: {savings:.1f}%"
            )
        else:
            return (
                f"Recommended: {optimal}\n"
                f"Quality: {opt_result['quality_score']:.1f}/10\n"
                f"Cost: ${opt_result['cost_per_fragment']:.4f}/fragment"
            )
    
    # Database operations
    async def _create_batch(self, model_config: ModelConfig) -> int:
        """Create processing batch record"""
        
        batch_code = f"BATCH_{datetime.now().strftime('%Y_%m_%d_%H%M%S')}"
        
        result = await self.db.fetchrow(
            """
            INSERT INTO processing_batches (
                batch_code, model_provider, model_name, 
                temperature, batch_status
            ) VALUES ($1, $2, $3, $4, 'processing')
            RETURNING id
            """,
            batch_code, model_config.provider, 
            model_config.name, model_config.temperature
        )
        
        return result["id"]
    
    async def _save_fragments(
        self,
        fragments: List[Dict],
        source_id: int,
        batch_id: int
    ):
        """Save fragments to database"""
        
        for fragment in fragments:
            # Generate fragment code
            fragment_code = await self._get_next_fragment_code(
                fragment["category"]
            )
            
            # Insert fragment
            await self.db.execute(
                """
                INSERT INTO fragments (
                    fragment_code, source_id, batch_id,
                    category, fragment_type, content,
                    location_in_source, context, insight,
                    relevance, confidence
                ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
                """,
                fragment_code, source_id, batch_id,
                fragment["category"], fragment["type"],
                fragment["content"], fragment.get("location", "Unknown"),
                fragment["context"], fragment["insight"],
                fragment["relevance"], fragment["confidence"]
            )
            
            # Add tags
            for tag in fragment.get("tags", []):
                await self._add_fragment_tag(fragment_code, tag)
    
    async def _calculate_quality_score(self, fragments: List[Dict]) -> float:
        """Calculate overall quality score for fragments"""
        
        if not fragments:
            return 0.0
        
        scores = []
        for f in fragments:
            # Weight by relevance and confidence
            score = f["relevance"] * f["confidence"]
            scores.append(score)
        
        return np.mean(scores)
    
    async def _update_batch_stats(self, batch_id: int, metrics: Dict):
        """Update batch statistics"""
        
        await self.db.execute(
            """
            UPDATE processing_batches
            SET 
                total_fragments_generated = $1,
                total_input_tokens = $2,
                total_output_tokens = $3,
                estimated_cost_usd = $4,
                batch_status = 'completed',
                completed_at = $5
            WHERE id = $6
            """,
            metrics["fragments_count"],
            metrics["input_tokens"],
            metrics["output_tokens"],
            metrics["cost"],
            datetime.now(),
            batch_id
        )
    
    async def _mark_batch_failed(self, batch_id: int, error: str):
        """Mark batch as failed"""
        
        await self.db.execute(
            """
            UPDATE processing_batches
            SET 
                batch_status = 'failed',
                error_message = $1,
                completed_at = $2
            WHERE id = $3
            """,
            error, datetime.now(), batch_id
        )
    
    async def _get_content_sample(
        self,
        source_id: int,
        sample_size: int = 2000
    ) -> str:
        """Get content sample for testing"""
        
        # This would fetch actual content from storage
        # For now, return placeholder
        return f"Sample content for source {source_id}..."
    
    async def _get_next_fragment_code(self, category: str) -> str:
        """Generate next fragment code"""
        
        result = await self.db.fetchrow(
            "SELECT get_next_fragment_code($1) as code",
            category
        )
        return result["code"]
    
    async def _add_fragment_tag(self, fragment_code: str, tag: str):
        """Add tag to fragment"""
        
        # Get or create tag
        tag_result = await self.db.fetchrow(
            """
            INSERT INTO tags (tag_name)
            VALUES ($1)
            ON CONFLICT (tag_name) 
            DO UPDATE SET usage_count = tags.usage_count + 1
            RETURNING id
            """,
            tag.lower()
        )
        
        # Get fragment id
        fragment_result = await self.db.fetchrow(
            "SELECT id FROM fragments WHERE fragment_code = $1",
            fragment_code
        )
        
        # Link fragment to tag
        await self.db.execute(
            """
            INSERT INTO fragment_tags (fragment_id, tag_id)
            VALUES ($1, $2)
            ON CONFLICT DO NOTHING
            """,
            fragment_result["id"], tag_result["id"]
        )
    
    async def _save_optimization_result(
        self,
        source_id: int,
        optimal_model: str,
        results: Dict
    ):
        """Save optimization results to database"""
        
        # Save model performance for each tested model
        for model_name, result in results.items():
            if "error" not in result:
                config = MODELS[model_name]
                
                await self.db.execute(
                    """
                    INSERT INTO model_performance (
                        model_provider, model_name, source_id,
                        batch_id, fragments_extracted,
                        extraction_quality_avg, cost_per_fragment,
                        time_per_fragment_seconds
                    ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
                    """,
                    config.provider, config.name, source_id,
                    result.get("batch_id"), result["fragments_count"],
                    result["quality_score"], result["cost_per_fragment"],
                    result["processing_time"] / result["fragments_count"]
                    if result["fragments_count"] > 0 else 0
                )


class ProcessingOrchestrator:
    """Orchestrate the entire processing pipeline"""
    
    def __init__(self, db_pool: asyncpg.Pool):
        self.db = db_pool
        self.optimizer = ModelOptimizer(db_pool)
    
    async def process_queue(self):
        """Process items from the queue"""
        
        while True:
            # Get next item from queue
            item = await self._get_next_queue_item()
            
            if not item:
                await asyncio.sleep(10)  # Wait if queue empty
                continue
            
            try:
                # Mark as processing
                await self._update_queue_status(
                    item["id"], ProcessingStatus.PROCESSING
                )
                
                # Determine optimal model
                optimal_result = await self.optimizer.progressive_optimization(
                    item["source_id"]
                )
                
                # Process with optimal model
                await self._process_source_full(
                    item["source_id"],
                    optimal_result["optimal_model"]
                )
                
                # Mark as completed
                await self._update_queue_status(
                    item["id"], ProcessingStatus.COMPLETED
                )
                
            except Exception as e:
                # Mark as failed
                await self._update_queue_status(
                    item["id"], ProcessingStatus.FAILED, str(e)
                )
                
                # Retry logic
                if item["attempts"] < item["max_attempts"]:
                    await self._requeue_item(item["id"])
    
    async def _get_next_queue_item(self) -> Optional[Dict]:
        """Get next item from processing queue"""
        
        return await self.db.fetchrow(
            """
            SELECT pq.*, s.source_code
            FROM processing_queue pq
            JOIN sources s ON pq.source_id = s.id
            WHERE pq.queue_status = 'waiting'
            ORDER BY 
                pq.priority DESC,
                pq.created_at ASC
            LIMIT 1
            FOR UPDATE SKIP LOCKED
            """
        )
    
    async def _update_queue_status(
        self,
        queue_id: int,
        status: ProcessingStatus,
        error: str = None
    ):
        """Update queue item status"""
        
        if error:
            await self.db.execute(
                """
                UPDATE processing_queue
                SET 
                    queue_status = $1,
                    error_message = $2,
                    updated_at = $3
                WHERE id = $4
                """,
                status.value, error, datetime.now(), queue_id
            )
        else:
            await self.db.execute(
                """
                UPDATE processing_queue
                SET 
                    queue_status = $1,
                    updated_at = $2
                WHERE id = $3
                """,
                status.value, datetime.now(), queue_id
            )
    
    async def _process_source_full(self, source_id: int, model_name: str):
        """Process entire source with selected model"""
        
        # Get full content
        content = await self._get_source_content(source_id)
        
        # Process with selected model
        model_config = MODELS[model_name]
        extractor = FragmentExtractor(self.db)
        
        # Create batch
        batch_id = await self.optimizer._create_batch(model_config)
        
        # Extract fragments
        fragments, metrics = await extractor.extract_fragments(
            source_id, content, model_config
        )
        
        # Save everything
        await self.optimizer._save_fragments(
            fragments, source_id, batch_id
        )
        
        await self.optimizer._update_batch_stats(batch_id, metrics)
    
    async def _get_source_content(self, source_id: int) -> str:
        """Get full source content"""
        
        # Would fetch from storage
        return f"Full content for source {source_id}"
    
    async def _requeue_item(self, queue_id: int):
        """Requeue failed item for retry"""
        
        await self.db.execute(
            """
            UPDATE processing_queue
            SET 
                queue_status = 'waiting',
                attempts = attempts + 1,
                scheduled_for = $1,
                updated_at = $2
            WHERE id = $3
            """,
            datetime.now() + timedelta(hours=1),
            datetime.now(),
            queue_id
        )


# Main execution
async def main():
    """Main execution function"""
    
    # Database connection
    db_pool = await asyncpg.create_pool(
        host="localhost",
        port=5432,
        user="mmos_user",
        password="mmos_password",
        database="mmos_db",
        min_size=10,
        max_size=20
    )
    
    # Initialize orchestrator
    orchestrator = ProcessingOrchestrator(db_pool)
    
    # Start processing queue
    await orchestrator.process_queue()
    
    # Close pool
    await db_pool.close()


if __name__ == "__main__":
    asyncio.run(main())
