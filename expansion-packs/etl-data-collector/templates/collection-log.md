# Data Collection Log

**Started:** {{start_time}}
**Completed:** {{end_time}}
**Duration:** {{duration_minutes}} minutes

## Configuration

- **Sources:** {{sources_file}}
- **Tiers:** {{tiers}}
- **Concurrency:** {{concurrency}}
- **Retry Strategy:** {{retry_strategy}}

## Summary

- **Total Sources:** {{total_sources}}
- **Successful:** {{successful}} ({{success_rate}}%)
- **Failed:** {{failed}}

## By Type

{{#each types}}
### {{name}}
- Total: {{total}}
- Successful: {{successful}}
- Failed: {{failed}}
- Success Rate: {{success_rate}}%

{{/each}}

## Errors

{{#each errors}}
### {{source_id}} ({{type}})
- **Error:** {{error}}
- **Retries:** {{retries}}
- **Status:** {{status}}

{{/each}}

## Quality Review

{{#if quality_issues}}
### Sources Needing Review

{{#each quality_issues}}
- **{{source_id}}:** {{issue}} ({{score}}% quality)

{{/each}}
{{/if}}

---

**Next Steps:**
{{#each next_steps}}
- {{.}}
{{/each}}
