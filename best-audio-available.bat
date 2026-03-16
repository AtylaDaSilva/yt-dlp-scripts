::Disable echo
@echo off

::Splash
echo ========== yt-dlp Scripts ==========
echo ------- Best Audio Available -------
echo ====================================

::Variables
set ERRMSG=
set "YT_URL=%1"

if not defined YT_URL (
    set ERRMSG=Missing or invalid URL parameter
    goto end
)

set "YT_URL_UNQUOTED=%~1"

if %YT_URL%==%YT_URL% (
    set ERRMSG=URL parameter appears to be unquotted. Make sure the URL is wrapped in double quotes
    goto end
)

set "FILE_PATH=C:\yt-dlp\out"
set "FILE_NAME=%%(title)s.%%(ext)s"
set FORMAT=ba
set "FFMPEG_PATH=C:\ffmpeg\bin\ffmpeg.exe"

::Echo params
echo %YT_URL%
@REM echo %YT_URL_UNQUOTED% DEBUG
echo %FILE_PATH%
echo %FILE_NAME%
echo %FORMAT%
echo %FFMPEG_PATH%

::Run command
:yt-dlp %YT_URL% -P %FILE_PATH% -o %FILE_NAME% -f %FORMAT% --no-playlist --ffmpeg-location %FFMPEG_PATH%

:end
if defined ERRMSG echo %ERRMSG%
echo Exiting...
::exit \b