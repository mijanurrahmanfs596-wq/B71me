@echo off
title BD-71 Mijanur Pro (10 Minimized Instances)
color 0A
cd /d "%~dp0"

echo ================================================================
echo       STARTING 10 MINIMIZED INSTANCES OF RCV.EXE
echo ================================================================
echo.

for /L %%i in (1,1,10) do (
    echo [+] Opening Minimized Instance %%i of 10...
    start "" /min "%~dp0RCV.exe"
    timeout /t 2 /nobreak >nul
)

echo.
echo ================================================================
echo  [SUCCESS] All 10 Minimized Instances Launched Successfully!
echo ================================================================
timeout /t 3 /nobreak >nul
exit
