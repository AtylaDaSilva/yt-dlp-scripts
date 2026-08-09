::Author: AtylaDaSilva (atyladasilva@outlook.com)
::Description: Downloads with the best available quality format that contains both audio and video.

::Params:
::  %1: YouTube URL
::  --output: Optional flag to remux the downloaded video in the desired extension. If the remuxing fails, it will fall back to mkv (or webm if mkv is specified).

::Disable echo
@echo off

::Splash
echo ========== yt-dlp Scripts ==========
echo ------- Best Audio Available -------
echo ====================================

::Read .ini file and set variables
for /f "tokens=1,2 delims=^=" %%A in (yt-dlp-scripts.ini) do (
    set "%%A=%%~B"
)

::Validations
set ERRMSG=
set "YT_URL=%1"

::Validations - Missing URL
if not defined YT_URL (
    set ERRMSG=Missing or invalid URL parameter
    goto end
)

::Validations - Unquoted URL
set "YT_URL_UNQUOTED=%~1"

if %YT_URL%==%YT_URL_UNQUOTED% (
    set ERRMSG=URL parameter appears to be unquotted. Make sure the URL is wrapped in double quotes
    goto end
)

::Echo params
echo ------------ Parameters ------------

@REM Download best format that contains video,
@REM and if it doesn't already have an audio stream, merge it with best audio-only format.
set FORMAT="bv*+ba/b"

if "%~2"=="--output" (
    if "%~3"=="mkv" (
        @REM Remuxes the downloaded video in the desired extension. Falls back to webm if the remuxing fails.
        set OUTPUT=--remux-video "%~3/webm"
    ) else (
        @REM Remuxes the downloaded video in the desired extension. Falls back to mkv if the remuxing fails.
        set OUTPUT=--remux-video "%~3/mkv"
    )
) else (
    set OUTPUT=
)

echo URL: %YT_URL%
echo FORMAT: %FORMAT%
echo FILE_PATH: %FILE_PATH%
echo FILE_NAME: %FILE_NAME%
echo FFMPEG_PATH: %FFMPEG_PATH%

set COMMAND=%YTDLP_PATH% %YT_URL% -f %FORMAT% %OUTPUT% --cookies-from-browser %COOKIES_FROM_BROWSER% -P %FILE_PATH% -o %FILE_NAME% --no-playlist --ffmpeg-location %FFMPEG_PATH%
echo %COMMAND%

::Run command
echo ------------ yt-dlp output start ----------
%COMMAND%
echo ------------  yt-dlp output end  -----------

:end
if defined ERRMSG echo %ERRMSG%
echo Exiting...
::exit \b