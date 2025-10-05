import sys
import os
from youtube_transcript_api import YouTubeTranscriptApi, TranscriptsDisabled, NoTranscriptFound, VideoUnavailable
from youtube_transcript_api.formatters import TextFormatter
from yt_dlp import YoutubeDL

# Define o ID do vídeo e o idioma
VIDEO_ID = sys.argv[1]
LANGUAGE = sys.argv[2] if len(sys.argv) > 2 else 'en'

# Opções para o yt-dlp
ydl_opts = {
    'skip_download': True,
}

# Tente baixar as informações do vídeo usando yt-dlp
video_info = None
try:
    with YoutubeDL(ydl_opts) as ydl:
        video_info = ydl.extract_info(VIDEO_ID, download=False)
except Exception as e:
    print(f'Erro ao baixar informações do vídeo com yt-dlp: {e}')

if video_info is None:
    print('Não foi possível obter as informações do vídeo')
else:
    # Obtenha o título do vídeo e o nome do canal
    video_title = video_info.get('title', None)
    channel_name = video_info.get('uploader', None)

    # Remove ou substitui caracteres ilegais no nome do arquivo
    for char in ['/', '\\', ':', '*', '?', '"', '<', '>', '|']:
        video_title = video_title.replace(char, '-')
        channel_name = channel_name.replace(char, '-')

    print(f'Título do vídeo: {video_title}')
    print(f'Nome do canal: {channel_name}')

    # Crie um diretório para o canal, se ainda não existir
    if not os.path.exists(channel_name):
        os.makedirs(channel_name)

    # Tente processar as legendas usando o youtube_transcript_api
    try:
        transcript_list = YouTubeTranscriptApi.list_transcripts(VIDEO_ID)
        transcript = transcript_list.find_transcript([LANGUAGE])
        formatter = TextFormatter()
        formatted_transcript = formatter.format_transcript(transcript.fetch())
    except TranscriptsDisabled:
        print(f'Transcrições estão desativadas para o vídeo {VIDEO_ID}')
    except NoTranscriptFound:
        print(f'Nenhuma transcrição encontrada para o vídeo {VIDEO_ID}')
    except VideoUnavailable:
        print(f'Vídeo {VIDEO_ID} não está disponível')
    except Exception as e:
        print(f'Erro ao processar as legendas com youtube_transcript_api: {e}')

    # Tente escrever a transcrição formatada em um arquivo
    try:
        with open(os.path.join(channel_name, f'{video_title}.txt'), 'w') as f:
            f.write(formatted_transcript)
    except Exception as e:
        print(f'Erro ao escrever a transcrição no arquivo: {e}')