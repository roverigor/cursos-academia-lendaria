import sys
import os
from youtube_transcript_api import YouTubeTranscriptApi, TranscriptsDisabled, NoTranscriptFound, VideoUnavailable
from youtube_transcript_api.formatters import TextFormatter
from yt_dlp import YoutubeDL

# Get the channel name from the command line arguments
try:
    CHANNEL_NAME = sys.argv[1]
except IndexError:
    print("Por favor, forneça o nome do canal como um argumento na linha de comando.")
    sys.exit()

LANGUAGE = sys.argv[2] if len(sys.argv) > 2 else 'en'

# Define the channel URL
CHANNEL_URL = f'https://www.youtube.com/@{CHANNEL_NAME}/videos'

# Create a directory with the name of the channel if it does not exist
if not os.path.exists(CHANNEL_NAME):
    os.makedirs(CHANNEL_NAME)

# Options for yt-dlp
ydl_opts = {
    'skip_download': True,
}

# Try to download the video info using yt-dlp
try:
    with YoutubeDL(ydl_opts) as ydl:
        info_dict = ydl.extract_info(CHANNEL_URL, download=False)
        videos_info = [(video['id'], video['title']) for video in info_dict['entries']]
except Exception as e:
    print(f'Erro ao baixar informações do vídeo com yt-dlp: {e}')

for video_id, video_title in videos_info:
    # Try to process the subtitles using youtube_transcript_api
    try:
        transcript_list = YouTubeTranscriptApi.list_transcripts(video_id)
        transcript = transcript_list.find_transcript([LANGUAGE])
        formatter = TextFormatter()
        formatted_transcript = formatter.format_transcript(transcript.fetch())
        # Remove or replace illegal characters in the file name
        for char in ['/', '\\', ':', '*', '?', '"', '<', '>', '|']:
            video_title = video_title.replace(char, '-')
        # Write the transcript to a file in the channel directory
        with open(os.path.join(CHANNEL_NAME, f'{video_title}.txt'), 'w') as f:
            f.write(formatted_transcript)
    except TranscriptsDisabled:
        print(f'Transcrições estão desativadas para o vídeo {video_id}')
    except NoTranscriptFound:
        print(f'Nenhuma transcrição encontrada para o vídeo {video_id}')
    except VideoUnavailable:
        print(f'Vídeo {video_id} não está disponível')
    except Exception as e:
        print(f'Erro ao processar as legendas com youtube_transcript_api: {e}')