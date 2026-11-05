@echo off
setlocal
cd /d "%~dp0"
where lilypond >nul 2>nul
if errorlevel 1 (echo LilyPond was not found on PATH. & pause & exit /b 1)
if not exist build mkdir build
lilypond -o "build\chopin-ballade-no-3-piano-solo" "chopin-ballade-no-3-piano-solo.ly" > "build\compile.log" 2>&1
set result=%errorlevel%
type "build\compile.log"
if not "%result%"=="0" (echo Compilation failed. & pause & exit /b %result%)
echo PDF and MIDI are in build.
pause
