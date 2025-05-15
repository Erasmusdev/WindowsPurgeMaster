@echo off
setlocal

:: Define variables
set "DOWNLOAD_URL=https://www.alcpu.com/CoreTemp/Core-Temp-setup-v1.18.1.0.exe"
set "INSTALLER_NAME=Core-Temp-setup.exe"
set "DOWNLOAD_PATH=%TEMP%\%INSTALLER_NAME%"

:: Full path to PowerShell executable (update if needed)
set "PowerShellPath=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"

:: Inform user
echo Downloading Core Temp from official source...
echo URL: %DOWNLOAD_URL%

:: Use full path to PowerShell to download the file
"%PowerShellPath%" -Command ^
    "try { Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%DOWNLOAD_PATH%' -UseBasicParsing; exit 0 } catch { exit 1 }"

if %ERRORLEVEL% NEQ 0 (
    echo Error downloading Core Temp.
    pause
    exit /b 1
)

:: Run the installer (check for silent install switch availability; this might not work on all versions)
echo Running Core Temp installer...
"%DOWNLOAD_PATH%" /SILENT

if %ERRORLEVEL% EQU 0 (
    echo Core Temp installation started successfully.
) else (
    echo Core Temp installation failed or may require manual steps.
)

:: Cleanup
del /f /q "%DOWNLOAD_PATH%" >nul 2>&1

pause
exit /b
