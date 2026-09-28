@echo off
title BD-71 Mijanur Pro (x5 Instances)
cd /d "%~dp0"

echo ================================================================
echo       STARTING 5 INSTANCES OF RCV SOFTWARE (x5 OPEN)
echo ================================================================
echo.

for /L %%i in (1,1,5) do (
    echo [+] Opening Instance %%i of 5...
    start "" "%~dp0RCV.exe"
    timeout /t 1 /nobreak >nul
)

echo.
echo [SUCCESS] All 5 instances opened successfully!
timeout /t 2 /nobreak >nul
exit