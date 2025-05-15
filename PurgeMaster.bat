@echo off
:: Ensure the full path to PowerShell is used to avoid issues
set "PowerShellPath=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"

:: Check if PowerShell exists at the given path
if not exist "%PowerShellPath%" (
    echo PowerShell is not found on this system. Exiting...
    exit /b
)

:: Check if running in PowerShell; if not, restart script inside PowerShell
echo Checking if running in PowerShell...
if defined _IN_POWER_SHELL (
    goto :Proceed
)

set _IN_POWER_SHELL=1
echo Not in PowerShell. Launching PowerShell and restarting script...
"%PowerShellPath%" -NoExit -ExecutionPolicy Bypass -Command "& '%~dp0%~nx0'"
exit /b

:Proceed

:: Initialize crash log
set "crashlog=%~dp0\crashlog.txt"
echo Crash Log > "%crashlog%"
echo ------------------- >> "%crashlog%"
echo. >> "%crashlog%"

:: Initialize logs
set "logs=%~dp0\logs.json"
echo { "logs": [] } > "%logs%"

:: Colors
FOR /F %%A IN ('echo prompt $E^|cmd') DO SET "ESC=%%A"
SET "blue=%ESC%[34m"
SET "green=%ESC%[32m"
SET "yellow=%ESC%[33m"
SET "red=%ESC%[31m"
SET "reset=%ESC%[0m"

:START
cls
echo %green%============================================================%reset%
echo %green%          PurgeMaster Cleanup Wizard v1.0.06 (Pre Release)       %reset%
echo %green%                  Copyright Flockers Design                     %reset%
echo %green%============================================================%reset%
echo            Support
echo ===============================
echo For support, please contact:
echo Github: https://github.com/Erasmusdev/WindowsPurgeMaster
echo.

:MENU
echo Please select an option:
echo 1. Clean Temporary Files
echo 2. Clean Prefetch Files
echo 3. Empty Recycle Bin
echo 4. Clean Windows Update Cache
echo 5. Clean Temporary Internet Files (Testing Phase)
echo 6. Delete System Error Memory Dump Files (Testing Phase)
echo 7. Delete Temporary Installation Files (Testing Phase)
echo 8. Clean Registry (Option not implemented yet)
echo 9. Clean Browser Cache and History (Option not implemented yet)
echo 10. Clean All (Automatically confirm with 'Y' for all)
echo 11. Run Network Settings Addon
echo 12. ---
echo 13. Install Software
echo 14. Exit (CTRL+C)
echo.

set /p option=Enter the number of your choice (1-14): 

if "%option%"=="" goto MENU
echo.%option%| findstr /r "^[1-9][0-9]*$" >nul || goto MENU

if %option%==1 call :confirm_cleanup "Clean Temporary Files" "%temp%"
if %option%==2 call :confirm_cleanup "Clean Prefetch Files" "C:\Windows\Prefetch"
if %option%==3 call :confirm_cleanup "Empty Recycle Bin"
if %option%==4 call :confirm_cleanup "Clean Windows Update Cache" "%windir%\SoftwareDistribution\Download"
if %option%==5 call :confirm_cleanup "Clean Temporary Internet Files" "%userprofile%\AppData\Local\Microsoft\Windows\INetCache"
if %option%==6 call :confirm_cleanup "Delete System Error Memory Dump Files" "%SystemRoot%\Minidump"
if %option%==7 call :confirm_cleanup "Delete Temporary Installation Files" "%SystemRoot%\Temp"
if %option%==8 (
    echo Option 8: Clean Registry (Not implemented)
    pause
)
if %option%==9 (
    echo Option 9: Clean Browser Cache and History (Not implemented)
    pause
)
if %option%==10 (
    echo Running Autocleaner.bat...
    call "%~dp0Addons\Autocleaner.bat"
    echo Autocleaner.bat execution completed.
    pause
)
if %option%==11 (
    echo Running NetworkSettingsAddon.bat...
    call "%~dp0Addons\NetworkSettingsAddon.bat"
    echo NetworkSettingsAddon.bat execution completed.
    pause
)
if %option%==13 goto INSTALL_MENU
if %option%==14 (
    echo Exiting cleanup wizard.
    exit /b
)

echo ERROR: Unexpected situation occurred. Please check the crash log: %crashlog%
echo Error occurred in option: %option% >> "%crashlog%"
echo. >> "%crashlog%"
echo Last command: %0 %* >> "%crashlog%"
echo Script location: %~dp0 >> "%crashlog%"
echo Date/Time: %date% %time% >> "%crashlog%"
echo. >> "%crashlog%"
pause
goto START

:INSTALL_MENU
cls
echo ==========================
echo   Software Installation
echo ==========================
echo 1. Install Core Temp (CPU Monitor)
echo 2. Install Revo Uninstaller
echo 3. Back to Main Menu
echo.

set /p installChoice=Enter your choice (1-3): 

if "%installChoice%"=="1" (
    echo Running InstallCoreTempAddon.bat...
    call "%~dp0Addons\InstallCoreTempAddon.bat"
    echo InstallCoreTempAddon.bat execution completed.

    :: Try launching Core Temp
    if exist "%ProgramFiles%\Core Temp\Core Temp.exe" (
        echo Launching Core Temp...
        start "" "%ProgramFiles%\Core Temp\Core Temp.exe"
    ) else if exist "%ProgramFiles(x86)%\Core Temp\Core Temp.exe" (
        echo Launching Core Temp...
        start "" "%ProgramFiles(x86)%\Core Temp\Core Temp.exe"
    ) else (
        echo Core Temp was not found after install. Please check installation path.
    )
    pause
    goto INSTALL_MENU
)

if "%installChoice%"=="2" (
    echo Running RevoUninstaller.bat...
    call "%~dp0Addons\RevoUninstaller.bat"
    echo RevoUninstaller.bat execution completed.

    :: Try launching Revo Uninstaller (basic assumption)
    if exist "%ProgramFiles%\VS Revo Group\Revo Uninstaller\Revouninstaller.exe" (
        echo Launching Revo Uninstaller...
        start "" "%ProgramFiles%\VS Revo Group\Revo Uninstaller\Revouninstaller.exe"
    ) else if exist "%ProgramFiles(x86)%\VS Revo Group\Revo Uninstaller\Revouninstaller.exe" (
        echo Launching Revo Uninstaller...
        start "" "%ProgramFiles(x86)%\VS Revo Group\Revo Uninstaller\Revouninstaller.exe"
    ) else (
        echo Revo Uninstaller was not found after install. Please check installation path.
    )
    pause
    goto INSTALL_MENU
)

if "%installChoice%"=="3" goto START

:: Fallback for invalid input
goto INSTALL_MENU

:confirm_cleanup
set "action=%~1"
set "path=%~2"

if "%auto_confirm%"=="Y" (
    set "choice=Y"
) else (
    echo Are you sure you want to %action%? (Y/N)
    set /p choice= 
)

if /i "%choice%"=="Y" (
    echo Performing %action%...
    if "%action%"=="Empty Recycle Bin" (
        echo Clearing Recycle Bin...
        "%PowerShellPath%" -ExecutionPolicy Bypass -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"
        set "spaceCleared=0"
    ) else (
        set "powershellCommand=Remove-Item -Recurse -Force '%path%'"
        set "beforeSize=0"
        for /f "tokens=3" %%a in ('"%PowerShellPath%" -Command "(Get-ChildItem -Recurse -Force '%path%' | Measure-Object -Property Length -Sum).Sum"') do set /a beforeSize+=%%a
        "%PowerShellPath%" -ExecutionPolicy Bypass -Command "%powershellCommand%" >nul 2>&1
        set "afterSize=0"
        for /f "tokens=3" %%a in ('"%PowerShellPath%" -Command "(Get-ChildItem -Recurse -Force '%path%' | Measure-Object -Property Length -Sum).Sum"') do set /a afterSize+=%%a
        set /a spaceCleared=beforeSize - afterSize
        mkdir "%path%" >nul 2>&1
    )
    echo %action% completed.
    call :log_cleanup "%action%" "%path%" "%spaceCleared%"
) else (
    echo %action% canceled.
)
pause
goto :eof

:log_cleanup
set "category=%~1"
set "path=%~2"
set "spaceCleared=%~3"
set "unit=Bytes"

for /f "usebackq tokens=1,2 delims=." %%a in (`echo %time%`) do (
    set "timestamp=%date%T%%a.%%b"
)
(
    echo { "category": "%category%", "path": "%path%", "spaceCleared": %spaceCleared%, "unit": "%unit%", "timestamp": "%timestamp%" }
) >> "%logs%"
goto :eof
