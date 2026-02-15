@echo off
setlocal enabledelayedexpansion

echo =====================================
echo     Audio + Video Merger (FFmpeg)
echo =====================================
echo.

:: Check if ffmpeg is available
where ffmpeg >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] FFmpeg not found. Please install FFmpeg first.
    echo.
    pause
    exit /b 1
)

:: Get audio file name
set /p audio_file="Enter audio file name/path (e.g., audio.mp4): "
if "!audio_file!"=="" (
    echo [ERROR] Audio file cannot be empty.
    echo.
    pause
    exit /b 1
)

:: Get video file name
set /p video_file="Enter video file name/path (e.g., video.mp4): "
if "!video_file!"=="" (
    echo [ERROR] Video file cannot be empty.
    echo.
    pause
    exit /b 1
)

:: Check if files exist
if not exist "!audio_file!" (
    echo [ERROR] Audio file not found: !audio_file!
    echo.
    pause
    exit /b 1
)

if not exist "!video_file!" (
    echo [ERROR] Video file not found: !video_file!
    echo.
    pause
    exit /b 1
)

:: Generate output file name
set output_file=merged_%random%.mp4
echo.
echo Merging files, please wait...
echo.

:: Run ffmpeg command
ffmpeg -i "!video_file!" -i "!audio_file!" -c:v copy -c:a aac -map 0:v:0 -map 1:a:0 -shortest "!output_file!"

:: Check result
if %errorlevel% equ 0 (
    echo.
    echo [SUCCESS] Merge completed!
    echo Output file: !output_file!
) else (
    echo.
    echo [ERROR] Merge failed. Please check file formats.
)

echo.
pause