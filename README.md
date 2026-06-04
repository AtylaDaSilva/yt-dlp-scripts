# yt-dlp-scripts

## Description

Windows batch wrappers around [yt-dlp](https://github.com/yt-dlp/yt-dlp) for downloading YouTube (and other supported) media. Each script reads shared settings from `yt-dlp-scripts.ini`, validates that you pass a quoted URL, then invokes yt-dlp with ffmpeg and browser cookies so private or age-restricted content can be fetched when you are logged in.

## Scripts

| Script | Purpose |
|--------|---------|
| `best-available.bat` | Downloads the best available combined format (audio and video in one file). |
| `best-available-720.bat` | Same as above, but prefers formats at 720p or lower (`-S "res:720"`). |
| `best-audio-available.bat` | Downloads the best available audio-only stream (`-f ba`). |

All scripts skip playlists (`--no-playlist`), which means that if you pass an URL that points to a video **and** a playlist, only the video will be downloaded. However if the URL points only to a playlist, the playlist will be downloaded normally.

## Local setup

1. **Clone the repository** to a folder on your PC.

2. **Install dependencies**
   - [yt-dlp](https://github.com/yt-dlp/yt-dlp#installation) — note the path to `yt-dlp.exe`.
   - [ffmpeg](https://ffmpeg.org/download.html) — note the path to `ffmpeg.exe`.

3. **Configure `yt-dlp-scripts.ini`** in the repo root:
   - `FILE_PATH` — directory where downloads are saved.
   - `FILE_NAME` — output template (default `%(title)s.%(ext)s`; see [yt-dlp output templates](https://github.com/yt-dlp/yt-dlp?tab=readme-ov-file#output-template)).
   - `FFMPEG_PATH` — full path to `ffmpeg.exe`.
   - `YTDLP_PATH` — full path to `yt-dlp.exe`.
   - `COOKIES_FROM_BROWSER` — browser used for cookies (e.g. `firefox`, `chrome`, `edge`). You must be logged into YouTube in that browser before running a script.

4. **Run a script** from the repo directory (or ensure `yt-dlp-scripts.ini` is found via the script’s working directory). Pass the media URL in **double quotes**:

   ```bat
   best-available.bat "https://www.youtube.com/watch?v=VIDEO_ID"
   ```


> [!NOTE]
> When copying the video URL, **DO NOT** copy the entire link with **all** the params (everything after the ```?``` is a param), only the "v" param is required. The scripts were not made to handle the extra URL params and will likely break if you pass those.
> 
> **Examples:**
> 
> ✅ Good: https://www.youtube.com/watch?v=ABCDEq123431xd
> 
> ❌ Bad: https://www.youtube.com/watch?v=ABCDEq123431xd&t=2425s
>
> To be safe, instead of copying the URL from your browser's search bar, click the video's "Share" button (should be right underneath it) and copy the link from there.