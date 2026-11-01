@echo off
setlocal EnableExtensions
title BD-71 Mijanur Pro (Auto Cleaner + 12 Slow Launch Instances)
color 0A
cd /d "%~dp0"

set "EXE=%~dp0RCV.exe"
set "TILER=%~dp0tile-brave.ps1"
set "COUNT=12"
set "DELAY=10"
set "TOKEN=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"
set "TILER_URL=https://raw.githubusercontent.com/mijanurrahmanfs596-wq/bd71Abd/main/tile-brave.ps1"

echo ================================================================
echo       INITIALIZING AUTO CLEANER AND 12 INSTANCES OF RCV.EXE
echo ================================================================
echo.

:: 1. Check and Auto-Download tile-brave.ps1 if missing
if not exist "%TILER%" (
    echo [*] tile-brave.ps1 not found locally. Auto-downloading from GitHub...
    curl.exe --ssl-no-revoke -s -H "Authorization: token %TOKEN%" -L -o "%TILER%" "%TILER_URL%"
    if not exist "%TILER%" (
        powershell -NoProfile -ExecutionPolicy Bypass -Command "try { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $h=@{Authorization='token %TOKEN%'}; Invoke-WebRequest -Uri '%TILER_URL%' -Headers $h -OutFile '%TILER%' } catch {}" >nul 2>nul
    )
    if exist "%TILER%" (
        echo [OK] tile-brave.ps1 successfully downloaded!
    ) else (
        echo [!] Warning: Could not download tile-brave.ps1. Continuing without window tiling...
    )
)

:: 2. Check if RdpAutoCleaner is already running
tasklist /fi "imagename eq RdpAutoCleaner.exe" 2>nul | find /i "RdpAutoCleaner.exe" >nul
if errorlevel 1 (
    echo [*] RdpAutoCleaner is NOT running. Launching minimized...
    if exist "%~dp0RdpAutoCleaner.exe" (
        start "" /min "%~dp0RdpAutoCleaner.exe"
    ) else if exist "C:\New folder\RdpAutoCleaner.exe" (
        start "" /min "C:\New folder\RdpAutoCleaner.exe"
    )
    ping 127.0.0.1 -n 3 >nul
) else (
    echo [OK] RdpAutoCleaner is ALREADY RUNNING. Skipping launch...
)

echo.
echo ================================================================
echo       STARTING 12 MINIMIZED INSTANCES (SLOW LAUNCH: %DELAY%s DELAY)
echo ================================================================
echo.

if not exist "%EXE%" (
    echo [!] RCV.exe paoa jay nai: "%EXE%"
    echo [!] Ei .bat file ta RCV.exe er same folder e rakhun.
    pause
    exit /b 1
)

set "BRAVE_BEFORE=%TEMP%\rcv_brave_before_%RANDOM%%RANDOM%.txt"
set "BRAVE_LOG=%TEMP%\rcv_tile_debug.log"
if exist "%TILER%" (
    powershell -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "%TILER%" -Capture -File "%BRAVE_BEFORE%" -LogFile "%BRAVE_LOG%" >nul 2>nul
)

for /L %%I in (1,1,%COUNT%) do (
    echo [+] [%%I/%COUNT%] Starting RCV.exe minimized - Delay %DELAY%s
    start "" /min "%EXE%"
    if not "%%I"=="%COUNT%" ping 127.0.0.1 -n 11 >nul
)

if exist "%TILER%" (
    echo.
    echo [*] Auto-Tiling %COUNT% Brave Windows on screen...
    powershell -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "%TILER%" -File "%BRAVE_BEFORE%" -ExpectedCount %COUNT% -LogFile "%BRAVE_LOG%" >nul 2>nul
)

if exist "%BRAVE_BEFORE%" del /q "%BRAVE_BEFORE%" >nul 2>nul

echo.
echo ================================================================
echo  [SUCCESS] All 12 Minimized Instances Launched Successfully!
echo ================================================================
ping 127.0.0.1 -n 4 >nul
exit /b 0
