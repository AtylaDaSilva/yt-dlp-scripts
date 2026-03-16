::Disable echo
@echo off

::Splash
echo ========== yt-dlp Scripts ==========
echo ------- Best Audio Available -------
echo ====================================

::Read .ini file
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

::File format - List of supported formats: https://github.com/yt-dlp/yt-dlp?tab=readme-ov-file#format-selection
set FILE_FORMAT=ba

::Echo params
echo ------------ Parameters ------------

echo URL: %YT_URL%
@REM echo %YT_URL_UNQUOTED% DEBUG
echo FILE_PATH: %FILE_PATH%
echo FILE_NAME: %FILE_NAME%
echo FILE_FORMAT: %FILE_FORMAT%
echo FFMPEG_PATH: %FFMPEG_PATH%

::Run command
echo ------------ yt-dlp output start -----------
yt-dlp %YT_URL% -P %FILE_PATH% -o %FILE_NAME% -f %FILE_FORMAT% --no-playlist --ffmpeg-location %FFMPEG_PATH%
echo ------------  yt-dlp output end  -----------

:end
if defined ERRMSG echo %ERRMSG%
echo Exiting...
::exit \b