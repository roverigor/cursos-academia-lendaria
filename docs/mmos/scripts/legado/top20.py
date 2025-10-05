import requests
import pandas as pd
import time
import json
from datetime import datetime
import logging
import gspread
from tenacity import retry, stop_after_attempt, wait_exponential

# Configuração de logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class InstagramReelsAnalyzer:
    def __init__(self, apify_token):
        self.apify_token = apify_token
        self.base_url = "https://api.apify.com/v2/acts/culc72xb7MP3EbaeX/runs"
        
    @retry(stop=stop_after_attempt(3), wait=wait_exponential(multiplier=1, min=4, max=10))
    def start_scraping(self, profile_url):
        """Inicia o scraping usando Apify com retry automático"""
        payload = {
            "startUrls": [profile_url],
            "resultsLimit": 100,
            "resultsType": "posts",
            "addParentData": False,
            "searchType": "user",
            "searchLimit": 1,
            "proxy": {
                "useApifyProxy": True,
                "apifyProxyGroups": ["RESIDENTIAL"]
            },
            "extendOutputFunction": """($) => {
                return {
                    viewCount: $('.video-view-count').text(),
                    likes: $('div[class*="like"] span').first().text(),
                    comments: $('div[class*="comment"] span').first().text(),
                    shares: $('div[class*="share"] span').first().text()
                }
            }"""
        }
        
        headers = {"Content-Type": "application/json"}
        
        response = requests.post(
            f"{self.base_url}?token={self.apify_token}",
            headers=headers,
            data=json.dumps(payload)
        )
        
        if response.status_code not in [200, 201]:
            raise Exception(f"Falha ao iniciar o Actor: {response.text}")
        logger.info("Actor iniciado com sucesso")
            
        run_data = response.json()
        return run_data["data"]["id"]
        
    def get_results(self, run_id):
        """Obtém resultados do scraping com polling"""
        run_status_url = f"https://api.apify.com/v2/actor-runs/{run_id}?token={self.apify_token}"
        
        while True:
            run_status_resp = requests.get(run_status_url)
            run_status_data = run_status_resp.json()
            status = run_status_data["data"]["status"]
            
            if status in ["SUCCEEDED", "FAILED", "TIMED_OUT", "ABORTED"]:
                break
                
            logger.info(f"Status atual da run: {status}")
            
            data = run_status_data.get('data', {})
            stats = data.get('stats', {})
            
            logger.info(f"Detalhes da execução:")
            logger.info(f"- Requests finalizadas: {stats.get('requestsFinished', 0)}")
            logger.info(f"- Items processados: {stats.get('itemsClaimed', 0)}")
            logger.info(f"- Unidades de computação: {data.get('computeUnits', 0)}")
            
            # Verifica se há mensagens de erro
            if 'errorMessage' in data:
                logger.warning(f"Mensagem de erro encontrada: {data['errorMessage']}")
                
            time.sleep(5)
            time.sleep(5)
            
        if status != "SUCCEEDED":
            error_details = run_status_data.get("data", {}).get("errorMessage", "Sem detalhes do erro")
            logger.error(f"Detalhes do erro: {error_details}")
            raise Exception(f"O Actor não concluiu com sucesso. Status: {status}. Erro: {error_details}")
            
        dataset_id = run_status_data["data"]["defaultDatasetId"]
        dataset_url = f"https://api.apify.com/v2/datasets/{dataset_id}/items?token={self.apify_token}&format=json"
        
        dataset_response = requests.get(dataset_url)
        if dataset_response.status_code != 200:
            raise Exception("Falha ao obter o dataset.")
            
        return self._process_results(dataset_response.json())
        
    def _process_results(self, results):
        """Processa os resultados e calcula as métricas"""
        processed_data = []
        
        for item in results:
            # Verifica se é um vídeo/reel
            if "videoViews" not in item:
                continue
                
            # Extrai métricas com tratamento de nulos
            views = item.get("videoViews", 0) or 0
            likes = item.get("likesCount", 0) or 0
            comments = item.get("commentsCount", 0) or 0
            shares = item.get("sharesCount", 0) or 0
            
            # Adiciona ao dataset
            processed_data.append({
                "Link": item.get("postUrl", ""),
                "Descrição": item.get("text", ""),
                "Visualizações": views,
                "Curtidas": likes,
                "Comentários": comments,
                "Compartilhamentos": shares,
                "Nota Engajamento": self._calculate_engagement_score(views, likes, comments, shares)
            })
            
        # Ordena por visualizações e pega top 20
        processed_data.sort(key=lambda x: x["Visualizações"], reverse=True)
        top_20 = processed_data[:20]
        
        # Adiciona ranking
        for i, item in enumerate(top_20, 1):
            item["Ranking"] = i
            
        return top_20
        
    def _calculate_engagement_score(self, views, likes, comments, shares):
        """Calcula nota de engajamento de 0 a 10"""
        if views == 0:
            return 0
            
        # Pesos para cada métrica
        comment_weight = 3
        share_weight = 3
        like_weight = 2
        view_weight = 1
        
        # Calcula ratios em relação às views
        comment_ratio = (comments / views) * comment_weight
        share_ratio = (shares / views) * share_weight
        like_ratio = (likes / views) * like_weight
        view_ratio = 1 * view_weight
        
        # Soma total dos pesos
        total_weight = comment_weight + share_weight + like_weight + view_weight
        
        # Calcula nota final (0-10)
        engagement_score = ((comment_ratio + share_ratio + like_ratio + view_ratio) / total_weight) * 10
        return round(engagement_score, 2)
        
    def export_to_sheets(self, data, sheet_id):
        """Exporta dados para Google Sheets com fallback para CSV"""
        df = pd.DataFrame(data, columns=[
            "Ranking",
            "Link",
            "Descrição",
            "Visualizações",
            "Curtidas",
            "Comentários",
            "Compartilhamentos",
            "Nota Engajamento"
        ])
        
        try:
            # Tenta exportar para Google Sheets
            gc = gspread.service_account(credentials=None)
            try:
                sheet = gc.open_by_url(sheet_id)
            except:
                sheet = gc.open_by_key(sheet_id)
            
            worksheet = sheet.get_worksheet(0)
            worksheet.clear()
            worksheet.update([df.columns.values.tolist()] + df.values.tolist())
            logger.info("Dados exportados com sucesso para Google Sheets")
            
        except Exception as e:
            logger.error(f"Erro ao exportar para Google Sheets: {str(e)}")
            logger.info("Exportando para CSV como fallback...")
            
            # Fallback para CSV
            filename = f"reels_analysis_{datetime.now().strftime('%Y%m%d_%H%M%S')}.csv"
            df.to_csv(filename, index=False, encoding='utf-8')
            logger.info(f"Dados exportados para {filename}")

def main():
    # Configurações
    APIFY_TOKEN = "apify_api_La8qfwy69yvB0ENEdciJlXc7xATvdd1kWsxs"
    PROFILE_URL = "https://www.instagram.com/hormozi"  # Exemplo
    SHEET_ID = "1qfZbWIy-REnYy_n1SJR2yL2rA42C88hr0zr9ouSokZc"
    
    # Inicializa analisador
    analyzer = InstagramReelsAnalyzer(APIFY_TOKEN)
    
    try:
        # Inicia o scraping
        run_id = analyzer.start_scraping(PROFILE_URL)
        logger.info(f"Scraping iniciado com run ID: {run_id}")
        
        # Obtém e processa os resultados
        results = analyzer.get_results(run_id)
        
        # Exporta resultados
        analyzer.export_to_sheets(results, SHEET_ID)
        
    except Exception as e:
        logger.error(f"Erro durante a execução: {str(e)}")

if __name__ == "__main__":
    main()