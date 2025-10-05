import sys
import os
from youtube_transcript_api import YouTubeTranscriptApi, TranscriptsDisabled, NoTranscriptFound, VideoUnavailable
from youtube_transcript_api.formatters import TextFormatter
from yt_dlp import YoutubeDL

# Obtenha o ID da playlist a partir dos argumentos da linha de comando
try:
    PLAYLIST_ID = sys.argv[1]
except IndexError:
    print("Por favor, forneça o ID da playlist como um argumento na linha de comando.")
    sys.exit()

# Defina a URL da playlist
PLAYLIST_URL = f'https://www.youtube.com/playlist?list={PLAYLIST_ID}'

# Crie um diretório com o nome da playlist se ele não existir
if not os.path.exists(PLAYLIST_ID):
    os.makedirs(PLAYLIST_ID)

# Opções para o yt-dlp
ydl_opts = {
    'skip_download': True,
}

# Tente baixar as informações dos vídeos usando o yt-dlp
try:
    with YoutubeDL(ydl_opts) as ydl:
        info_dict = ydl.extract_info(PLAYLIST_URL, download=False)
        videos_info = [(video['id'], video['title']) for video in info_dict['entries']]
except Exception as e:
    print(f'Erro ao baixar informações do vídeo com yt-dlp: {e}')

for video_id, video_title in videos_info:
    # Tente processar as legendas usando a youtube_transcript_api
    try:
        transcript_list = YouTubeTranscriptApi.list_transcripts(video_id)
        transcript = transcript_list.find_transcript(['pt'])
        formatter = TextFormatter()
        formatted_transcript = formatter.format_transcript(transcript.fetch())
        # Remova ou substitua caracteres ilegais no nome do arquivo
        for char in ['/', '\\', ':', '*', '?', '"', '<', '>', '|']:
            video_title = video_title.replace(char, '-')
        # Escreva a transcrição em um arquivo no diretório da playlist
        with open(os.path.join(PLAYLIST_ID, f'{video_title}.txt'), 'w') as f:
            f.write(formatted_transcript)
    except TranscriptsDisabled:
        print(f'Transcrições estão desativadas para o vídeo {video_id}')
    except NoTranscriptFound:
        print(f'Nenhuma transcrição encontrada para o vídeo {video_id}')
    except VideoUnavailable:
        print(f'Vídeo {video_id} não está disponível')
    except Exception as e:
        print(f'Erro ao processar as legendas com youtube_transcript_api: {e}')
