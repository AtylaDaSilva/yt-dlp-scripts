::Disable echo
@echo off

::Splash
echo ========== yt-dlp Scripts ==========
echo ------- Best Audio Available -------
echo ====================================

::Variables
set "YT_URL=%~1"

if not defined YT_URL (
    echo "Missing URL"
    exit \b
)


set "FILE_PATH=C:\yt-dlp\out"
set "FILE_NAME=%%(title)s.%%(ext)s"
set FORMAT=ba
set "FFMPEG_PATH=C:\ffmpeg\bin\ffmpeg.exe"

::Echo params
echo %YT_URL%
echo %FILE_PATH%
echo %FILE_NAME%
echo %FORMAT%
echo %FFMPEG_PATH%

::Run command
yt-dlp %YT_URL% -P %FILE_PATH% -o %FILE_NAME% -f %FORMAT% --no-playlist --ffmpeg-location %FFMPEG_PATH%