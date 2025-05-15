@echo off
setlocal

:: Set URL for Revo Uninstaller Free (direct download)
set "downloadURL=https://download.revouninstaller.com/download/revosetup.exe"
set "installerName=revosetup.exe"
set "installerPath=%TEMP%\%installerName%"

:: Full path to PowerShell executable (update if needed)
set "PowerShellPath=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"

echo Downloading Revo Uninstaller Free...

:: Use full path to PowerShell to download the installer
"%PowerShellPath%" -Command "Invoke-WebRequest -Uri '%downloadURL%' -OutFile '%installerPath%'"

if exist "%installerPath%" (
    echo Download complete. Launching installer...

    :: Run the installer (standard mode; user interaction allowed)
    start "" "%installerPath%"

    echo Installer launched.
) else (
    echo Failed to download Revo Uninstaller. Check internet connection or URL.
)

endlocal
exit /b
