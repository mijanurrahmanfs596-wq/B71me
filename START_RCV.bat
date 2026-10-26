@echo off
title BD-71 Mijanur Pro (Auto Cleaner + 12 Minimized Instances)
color 0A
cd /d "%~dp0"

echo ================================================================
echo       INITIALIZING AUTO CLEANER & 12 INSTANCES OF RCV.EXE
echo ================================================================
echo.

:: 1. Check if RdpAutoCleaner is already running
tasklist /fi "imagename eq RdpAutoCleaner.exe" 2>nul | find /i "RdpAutoCleaner.exe" >nul
if errorlevel 1 (
    echo [*] RdpAutoCleaner is NOT running. Launching minimized...
    if exist "%~dp0RdpAutoCleaner.exe" (
        start "" /min "%~dp0RdpAutoCleaner.exe"
    ) else if exist "C:\New folder\RdpAutoCleaner.exe" (
        start "" /min "C:\New folder\RdpAutoCleaner.exe"
    )
    timeout /t 2 /nobreak >nul
) else (
    echo [OK] RdpAutoCleaner is ALREADY RUNNING. Skipping launch...
)

echo.
echo ================================================================
echo       STARTING 12 MINIMIZED INSTANCES OF RCV.EXE
echo ================================================================
echo.

for /L %%i in (1,1,12) do (
    echo [+] Opening Minimized Instance %%i of 12...
    start "" /min "%~dp0RCV.exe"
    timeout /t 2 /nobreak >nul
)

echo.
echo ================================================================
echo  [SUCCESS] All 12 Minimized Instances Launched Successfully!
echo ================================================================
timeout /t 3 /nobreak >nul
exit
