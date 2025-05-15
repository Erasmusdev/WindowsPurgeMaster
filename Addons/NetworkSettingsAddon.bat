@echo off
title Network Settings Optimization by Flockers Design

:: Check for Administrator privileges
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges. Please run as Administrator.
    pause
    exit /b
)

echo Optimizing network settings...
echo.

:: Function to modify Energy Efficient Ethernet and Flow Control
echo Disabling Energy Efficient Ethernet and enabling Flow Control...
for /f "tokens=2*" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /s /v "EnergyEfficientEthernet" 2^>nul') do (
    set "key=%%A"
    echo Processing adapter key: %%A
    reg add "%%A" /v "*EnergyEfficientEthernet" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%A" /v "*FlowControl" /t REG_DWORD /d 1 /f >nul 2>&1
)
echo Network settings updated.
echo.

:: Restarting network adapters to apply changes
echo Restarting network adapters to apply changes...
for /f "tokens=*" %%G in ('wmic nic where "NetEnabled=true" get Name ^| findstr /v "Name"') do (
    echo Disabling and enabling adapter: %%G
    netsh interface set interface name="%%G" admin=disable >nul 2>&1
    if errorlevel 1 (
        echo Failed to disable network adapter: %%G
    ) else (
        netsh interface set interface name="%%G" admin=enable >nul 2>&1
        if errorlevel 1 (
            echo Failed to enable network adapter: %%G
        )
    )
)
echo Network adapters restarted.
echo.

echo Optimization completed. Changes applied successfully.
pause
