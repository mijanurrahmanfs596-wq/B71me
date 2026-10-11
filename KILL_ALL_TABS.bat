@echo off
title BD-71 / RCV - Emergency Process & Tab Killer
color 0C
cd /d "%~dp0"

echo ================================================================
echo       KILLING ALL BROWSER TABS, POPUPS & BOT ENGINES
echo ================================================================
echo.

echo [+] Closing Brave & Chrome Browsers...
taskkill /f /t /im brave.exe 2>nul
taskkill /f /t /im brave-portable.exe 2>nul
taskkill /f /t /im chrome.exe 2>nul
taskkill /f /t /im chromedriver.exe 2>nul

echo [+] Closing Copy Buttons Popups & Python Engines...
taskkill /f /t /im python.exe 2>nul
taskkill /f /t /im pythonw.exe 2>nul

echo [+] Closing RCV & BD71 Master Processes...
taskkill /f /t /im RCV.exe 2>nul
taskkill /f /t /im bd71_engine.exe 2>nul
taskkill /f /t /im "Free_Master_Recovary v34.exe" 2>nul
taskkill /f /t /im "Free_Master_Recovary v35.exe" 2>nul
taskkill /f /t /im BD-71_V35.exe 2>nul

echo [+] Deep cleaning lingering window handles via PowerShell...
powershell -NoProfile -Command "Get-Process | Where-Object { $_.MainWindowTitle -like '*Copy Buttons*' -or $_.MainWindowTitle -like '*SwitchyOmega*' -or $_.MainWindowTitle -like '*No internet*' -or $_.ProcessName -in @('brave','brave-portable','chromedriver','bd71_engine','RCV') } | Stop-Process -Force -ErrorAction SilentlyContinue" 2>nul

echo.
echo ================================================================
echo  [SUCCESS] All Tabs, Browsers & Popups Closed Instantly!
echo ================================================================
timeout /t 2 /nobreak >nul
exit
