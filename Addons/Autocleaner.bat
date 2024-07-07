@echo off
title PurgeMaster Cleanup Wizard by Flockers Design
echo Running Windows 11 Cleanup Operations...
echo.

:: Cleanup temporary files
echo Cleaning up temporary files...
del /s /q %SystemRoot%\Temp\*
del /s /q %TEMP%\*
echo Temporary files cleaned up.
echo.

:: Cleanup Windows Update files
echo Cleaning up Windows Update files...
del /s /q %SystemRoot%\SoftwareDistribution\Download\*
echo Windows Update files cleaned up.
echo.

:: Cleanup recycle bin
echo Emptying recycle bin...
echo Y | powershell -Command Clear-RecycleBin
echo Recycle bin emptied.
echo.

:: Cleanup system restore points
echo Deleting old system restore points...
vssadmin delete shadows /for=%SystemDrive% /all /quiet
echo Old system restore points deleted.
echo.

:: Cleanup thumbnail cache
echo Cleaning up thumbnail cache...
del /s /q /f %LocalAppData%\Microsoft\Windows\Explorer\*.db
echo Thumbnail cache cleaned up.
echo.

:: Cleanup log files
echo Cleaning up log files...
for /f "tokens=*" %%G in ('wevtutil.exe el') do (
    wevtutil.exe cl "%%G"
    if %errorlevel% neq 0 (
        echo Failed to clear log %%G.
    )
)
echo Log files cleaned up.
echo.

echo All cleanup operations completed.

pause
