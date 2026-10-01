@echo off
title BD-71 Mijanur Pro (x5 Instances)
cd /d "%~dp0"

echo ================================================================
echo       STARTING 5 INSTANCES OF RCV SOFTWARE (x10 OPEN)
echo ================================================================
echo.

for /L %%i in (1,1,10) do (
    echo [+] Opening Instance %%i of 10...
    start "" "%~dp0RCV.exe"
    timeout /t 1 /nobreak >nul
)

echo.
echo [SUCCESS] All 10 instances opened successfully!
timeout /t 2 /nobreak >nul
exit
