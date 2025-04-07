@echo off
REM ============================================================
REM                 YukiPost Setup Script
REM ============================================================

REM Set display color and character encoding to UTF-8
color 9F
chcp 65001 >nul

REM Set the title
Title YukiPost

REM Enable Delayed Expansion
Setlocal EnableDelayedExpansion

REM ------------------------------------------------------------
REM            Check for Administrator Privileges
REM ------------------------------------------------------------
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges.
    echo Attempting to relaunch with elevated rights...
    powershell -Command "Start-Process -Verb RunAs -FilePath '%~f0'"
    exit /b
)

REM ------------------------------------------------------------
REM           Create Working Directory and Log File
REM ------------------------------------------------------------
mkdir "%userprofile%\Desktop\YukiPost" 2>nul
set "yuki=%userprofile%\Desktop\YukiPost"
set "logfile=%yuki%\YukiPost.log"

REM ------------------------------------------------------------
REM                    Initial Message
REM ------------------------------------------------------------
cls
echo === YukiPost Started ===
echo.
echo Please make sure you are connected to the Internet before proceeding.
echo.
timeout /t 3 /nobreak
echo === Press Any Key To Continue ===
pause >nul

REM ============================================================
REM                  Time Zone Selection
REM ============================================================
:TimeSelect
cls
echo Please Select Your Time Zone:
echo.
echo   1. Eastern Standard Time (EST)       12. Western European Time (WET)
echo   2. Central Standard Time (CST-US)    13. Eastern European Time (EET)
echo   3. Mountain Standard Time (MST)       14. Moscow Standard Time (MSK)
echo   4. Pacific Standard Time (PST)        15. Universal Time Coordinated (UTC)
echo   5. Greenwich Mean Time (GMT)          16. Hawaii-Aleutian Standard Time (HAST)
echo   6. Central European Time (CET)        17. Alaska Standard Time (AKST)
echo   7. India Standard Time (IST)          18. Atlantic Daylight Time (ADT)
echo   8. China Standard Time (CST-CN)       19. Western Australian Standard Time (WAST)
echo   9. Japan Standard Time (JST)          20. Korea Standard Time (KST)
echo  10. Atlantic Standard Time (AST)       21. Australian Eastern Standard Time (AEST)
echo  11. Newfoundland Standard Time (NST)   22. Other Time Zone                                    
echo.
set /p TimeZone=Please Enter Your Time Zone (Enter Number): 
if "%TimeZone%"=="1" goto EST
if "%TimeZone%"=="2" goto CSTUS
if "%TimeZone%"=="3" goto MST
if "%TimeZone%"=="4" goto PST
if "%TimeZone%"=="5" goto GMT
if "%TimeZone%"=="6" goto CET
if "%TimeZone%"=="7" goto IST
if "%TimeZone%"=="8" goto CSTCN
if "%TimeZone%"=="9" goto JST
if "%TimeZone%"=="10" goto AST
if "%TimeZone%"=="11" goto NST
if "%TimeZone%"=="12" goto WET
if "%TimeZone%"=="13" goto EET
if "%TimeZone%"=="14" goto MSK
if "%TimeZone%"=="15" goto UTC
if "%TimeZone%"=="16" goto HAST
if "%TimeZone%"=="17" goto AKST
if "%TimeZone%"=="18" goto ADT
if "%TimeZone%"=="19" goto WAST
if "%TimeZone%"=="20" goto KST
if "%TimeZone%"=="21" goto AEST
if "%TimeZone%"=="22" goto OtherTimeZone

echo Invalid Choice... Try Again.
timeout /t 2 /nobreak
goto TimeSelect

REM ------------------------------------------------------------
REM               Time Zone Setting Sections
REM ------------------------------------------------------------
:EST
cls
echo Setting Time Zone To Eastern Standard Time (EST)...
tzutil /s "Eastern Standard Time"
w32tm /resync
goto Install7zip

:CSTUS
cls
echo Setting Time Zone To Central Standard Time (CST-US)...
tzutil /s "Central Standard Time"
w32tm /resync
goto Install7zip

:MST
cls
echo Setting Time Zone To Mountain Standard Time (MST)...
tzutil /s "Mountain Standard Time"
w32tm /resync
goto Install7zip

:PST
cls
echo Setting Time Zone To Pacific Standard Time (PST)...
tzutil /s "Pacific Standard Time"
w32tm /resync
goto Install7zip

:GMT
cls
echo Setting Time Zone To Greenwich Mean Time (GMT)...
tzutil /s "GMT Standard Time"
w32tm /resync
goto Install7zip

:CET
cls
echo Setting Time Zone To Central European Time (CET)...
tzutil /s "Central European Standard Time"
w32tm /resync
goto Install7zip

:IST
cls
echo Setting Time Zone To India Standard Time (IST)...
tzutil /s "India Standard Time"
w32tm /resync
goto Install7zip

:CSTCN
cls
echo Setting Time Zone To China Standard Time (CST-CN)...
tzutil /s "China Standard Time"
w32tm /resync
goto Install7zip

:JST
cls
echo Setting Time Zone To Japan Standard Time (JST)...
tzutil /s "Tokyo Standard Time"
w32tm /resync
goto Install7zip

:AST
cls
echo Setting Time Zone To Atlantic Standard Time (AST)...
tzutil /s "Atlantic Standard Time"
w32tm /resync
goto Install7zip

:NST
cls
echo Setting Time Zone To Newfoundland Standard Time (NST)...
tzutil /s "Newfoundland Standard Time"
w32tm /resync
goto Install7zip

:WET
cls
echo Setting Time Zone To Western European Time (WET)...
tzutil /s "W. Europe Standard Time"
w32tm /resync
goto Install7zip

:EET
cls
echo Setting Time Zone To Eastern European Time (EET)...
tzutil /s "E. Europe Standard Time"
w32tm /resync
goto Install7zip

:MSK
cls
echo Setting Time Zone To Moscow Standard Time (MSK)...
tzutil /s "Russian Standard Time"
w32tm /resync
goto Install7zip

:UTC
cls
echo Setting Time Zone To Universal Time Coordinated (UTC)...
tzutil /s "UTC"
w32tm /resync
goto Install7zip

:HAST
cls
echo Setting Time Zone To Hawaii-Aleutian Standard Time (HAST)...
tzutil /s "Hawaiian Standard Time"
w32tm /resync
goto Install7zip

:AKST
cls
echo Setting Time Zone To Alaska Standard Time (AKST)...
tzutil /s "Alaskan Standard Time"
w32tm /resync
goto Install7zip

:ADT
cls
echo Setting Time Zone To Atlantic Daylight Time (ADT)...
tzutil /s "Atlantic Standard Time"
w32tm /resync
goto Install7zip

:WAST
cls
echo Setting Time Zone To Western Australian Standard Time (WAST)...
tzutil /s "W. Australia Standard Time"
w32tm /resync
goto Install7zip

:KST
cls
echo Setting Time Zone To Korea Standard Time (KST)...
tzutil /s "Korea Standard Time"
w32tm /resync
goto Install7zip

:AEST
cls
echo Setting Time Zone To Australian Eastern Standard Time (AEST)...
tzutil /s "AUS Eastern Standard Time"
w32tm /resync
goto Install7zip

:OtherTimeZone
cls
echo Opening Time Zone settings...
timedate.cpl ,3
echo Please change the time zone to yours and click "OK" then "Apply".
pause >nul
goto Install7zip

REM ============================================================
REM                       Install 7zip
REM ============================================================
:Install7zip
cls
echo Downloading 7zip...
curl -L -o "%yuki%\7z2201-x64.exe" "https://www.7-zip.org/a/7z2201-x64.exe"
if %errorlevel% neq 0 (
    echo Failed to download 7zip. Please check your internet connection.
    exit /b
)
cls
start "" /wait "%yuki%\7z2201-x64.exe" /S
if %errorlevel% neq 0 (
    echo 7zip installation encountered an error.
    exit /b
)
del /f "%yuki%\7z2201-x64.exe"
echo 7zip download and installation complete.
timeout /t 2 /nobreak

REM ============================================================
REM              Install Visual C++ Redistributable
REM ============================================================
cls
echo Downloading Visual C++ Redistributable...
curl -L -o "%yuki%\vcredist_x64.exe" "https://aka.ms/vs/17/release/vc_redist.x64.exe"
if %errorlevel% neq 0 (
    echo Failed to download Visual C++ Redistributable.
    exit /b
)
start "" /wait "%yuki%\vcredist_x64.exe" /S
del /f "%yuki%\vcredist_x64.exe"
timeout /t 2 /nobreak

REM ============================================================
REM                  Install .NET Runtimes
REM ============================================================
cls
echo Installing .NET 5.0 Runtime...
curl -L -o "%yuki%\aspnetcore-runtime-5.0.17-win-x64.exe" "https://download.visualstudio.microsoft.com/download/pr/3789ec90-2717-424f-8b9c-3adbbcea6c16/2085cc5ff077b8789ff938015392e406/aspnetcore-runtime-5.0.17-win-x64.exe"
if %errorlevel% neq 0 (
    echo Failed to download .NET 5.0 (x64).
    exit /b
)
start "" /wait "%yuki%\aspnetcore-runtime-5.0.17-win-x64.exe" /S
del "%yuki%\aspnetcore-runtime-5.0.17-win-x64.exe"

curl -L -o "%yuki%\aspnetcore-runtime-5.0.17-win-x86.exe" "https://download.visualstudio.microsoft.com/download/pr/4bfa247d-321d-4b29-a34b-62320849059b/8df7a17d9aad4044efe9b5b1c423e82c/aspnetcore-runtime-5.0.17-win-x86.exe"
if %errorlevel% neq 0 (
    echo Failed to download .NET 5.0 (x86).
    exit /b
)
start "" /wait "%yuki%\aspnetcore-runtime-5.0.17-win-x86.exe" /S
del "%yuki%\aspnetcore-runtime-5.0.17-win-x86.exe"

cls
echo Installing .NET 6.0 Runtime...
curl -L -o "%yuki%\windowsdesktop-runtime-6.0.36-win-x64.exe" "https://download.visualstudio.microsoft.com/download/pr/f6b6c5dc-e02d-4738-9559-296e938dabcb/b66d365729359df8e8ea131197715076/windowsdesktop-runtime-6.0.36-win-x64.exe"
if %errorlevel% neq 0 (
    echo Failed to download .NET 6.0 (x64).
    exit /b
)
start "" /wait "%yuki%\windowsdesktop-runtime-6.0.36-win-x64.exe" /S
del "%yuki%\windowsdesktop-runtime-6.0.36-win-x64.exe"

curl -L -o "%yuki%\windowsdesktop-runtime-6.0.36-win-x86.exe" "https://download.visualstudio.microsoft.com/download/pr/cdc314df-4a4c-4709-868d-b974f336f77f/acd5ab7637e456c8a3aa667661324f6d/windowsdesktop-runtime-6.0.36-win-x86.exe"
if %errorlevel% neq 0 (
    echo Failed to download .NET 6.0 (x86).
    exit /b
)
start "" /wait "%yuki%\windowsdesktop-runtime-6.0.36-win-x86.exe" /S
del "%yuki%\windowsdesktop-runtime-6.0.36-win-x86.exe"

cls
echo Installing .NET 7.0 Runtime...
curl -L -o "%yuki%\windowsdesktop-runtime-7.0.20-win-x64.exe" "https://download.visualstudio.microsoft.com/download/pr/08bbfe8f-812d-479f-803b-23ea0bffce47/c320e4b037f3e92ab7ea92c3d7ea3ca1/windowsdesktop-runtime-7.0.20-win-x64.exe"
if %errorlevel% neq 0 (
    echo Failed to download .NET 7.0 (x64).
    exit /b
)
start "" /wait "%yuki%\windowsdesktop-runtime-7.0.20-win-x64.exe" /S
del "%yuki%\windowsdesktop-runtime-7.0.20-win-x64.exe"

curl -L -o "%yuki%\windowsdesktop-runtime-7.0.20-win-x86.exe" "https://download.visualstudio.microsoft.com/download/pr/b840017b-c69f-4724-a152-11020a0039e6/b74aa12e4ee765a3387a7dcd4ba56187/windowsdesktop-runtime-7.0.20-win-x86.exe"
if %errorlevel% neq 0 (
    echo Failed to download .NET 7.0 (x86).
    exit /b
)
start "" /wait "%yuki%\windowsdesktop-runtime-7.0.20-win-x86.exe" /S
del "%yuki%\windowsdesktop-runtime-7.0.20-win-x86.exe"

cls
echo Installing .NET 8.0 Runtime...
curl -L -o "%yuki%\windowsdesktop-runtime-8.0.11-win-x64.exe" "https://download.visualstudio.microsoft.com/download/pr/27bcdd70-ce64-4049-ba24-2b14f9267729/d4a435e55182ce5424a7204c2cf2b3ea/windowsdesktop-runtime-8.0.11-win-x64.exe"
if %errorlevel% neq 0 (
    echo Failed to download .NET 8.0 (x64).
    exit /b
)
start "" /wait "%yuki%\windowsdesktop-runtime-8.0.11-win-x64.exe" /S
del "%yuki%\windowsdesktop-runtime-8.0.11-win-x64.exe"

curl -L -o "%yuki%\windowsdesktop-runtime-8.0.11-win-x86.exe" "https://download.visualstudio.microsoft.com/download/pr/6e1f5faf-ee7d-4db0-9111-9e270a458342/4cdcd1af2d6914134308630f048fbdfc/windowsdesktop-runtime-8.0.11-win-x86.exe"
if %errorlevel% neq 0 (
    echo Failed to download .NET 8.0 (x86).
    exit /b
)
start "" /wait "%yuki%\windowsdesktop-runtime-8.0.11-win-x86.exe" /S
del "%yuki%\windowsdesktop-runtime-8.0.11-win-x86.exe"

cls
echo Installing .NET 9.0 Runtime...
curl -L -o "%yuki%\windowsdesktop-runtime-9.0.0-win-x64.exe" "https://download.visualstudio.microsoft.com/download/pr/685792b6-4827-4dca-a971-bce5d7905170/1bf61b02151bc56e763dc711e45f0e1e/windowsdesktop-runtime-9.0.0-win-x64.exe"
if %errorlevel% neq 0 (
    echo Failed to download .NET 9.0 (x64).
    exit /b
)
start "" /wait "%yuki%\windowsdesktop-runtime-9.0.0-win-x64.exe" /S

curl -L -o "%yuki%\windowsdesktop-runtime-9.0.0-win-x86.exe" "https://download.visualstudio.microsoft.com/download/pr/8dfbde7b-c316-418d-934a-d3246253f342/69c6a35b77a4f01b95588e1df2bddf9a/windowsdesktop-runtime-9.0.0-win-x86.exe"
if %errorlevel% neq 0 (
    echo Failed to download .NET 9.0 (x86).
    exit /b
)
start "" /wait "%yuki%\windowsdesktop-runtime-9.0.0-win-x86.exe" /S
del "%yuki%\windowsdesktop-runtime-9.0.0-win-x86.exe"
timeout /t 2 /nobreak

REM ============================================================
REM                     Install DirectX
REM ============================================================
cls
echo Installing DirectX...
curl -L -o "%yuki%\directx_Jun2010_redist.exe" "https://download.microsoft.com/download/8/4/a/84a35bf1-dafe-4ae8-82af-ad2ae20b6b14/directx_Jun2010_redist.exe"
if %errorlevel% neq 0 (
    echo Failed to download DirectX. Skipping installation...
    goto BrowserSelect
)
cls
echo Please accept the license agreement.
echo Then click Browse, select the "%userprofile%" folder, and click OK.
pause >nul
start "" /wait "%userprofile%\directx_Jun2010_redist.exe"
if %errorlevel% neq 0 (
    echo DirectX setup was closed or failed. Logging error and skipping installation...
    echo DirectX Failed to Install. >> "%yuki%\YukiPost_Error.log"
    goto BrowserSelect
)
REM (Assuming DXSETUP.exe is called within the redist package)
del /f "%yuki%\directx_Jun2010_redist.exe"
echo DirectX installation complete.
pause >nul

REM ============================================================
REM                Browser Selection
REM ============================================================
:BrowserSelect
cls
echo Select the Web Browser you prefer:
echo.
echo   1. Thorium (Anti-Spy Chrome)
echo   2. Librewolf (Anti-Spy Firefox)
echo   3. Brave
echo.
choice /C 123 /M "Choose your web browser:"
if errorlevel 3 goto BraveBrowser
if errorlevel 2 goto LibrewolfBrowser
if errorlevel 1 goto ThoriumBrowser

REM ------------------------------------------------------------
REM      Browser Download & Installation Sections
REM ------------------------------------------------------------
:ThoriumBrowser
cls
echo Downloading Thorium Browser...
curl -L -o "%yuki%\thorium_AVX2_mini_installer.exe" "https://github.com/Alex313031/Thorium-Win/releases/download/M121.0.6167.204/thorium_AVX2_mini_installer.exe"
if %errorlevel% neq 0 (
    echo Failed to download Thorium Browser.
    exit /b
)
start "" "%yuki%\thorium_AVX2_mini_installer.exe"
del /f "%yuki%\thorium_AVX2_mini_installer.exe"
pause
goto GPUDrivers

:LibrewolfBrowser
cls
echo Downloading Librewolf Browser...
curl -L -o "%yuki%\librewolf-137.0-3-windows-x86_64-setup.exe" "https://gitlab.com/api/v4/projects/44042130/packages/generic/librewolf/137.0-3/librewolf-137.0-3-windows-x86_64-setup.exe"
if %errorlevel% neq 0 (
    echo Failed to download Librewolf Browser.
    exit /b
)
start "" "%yuki%\librewolf-137.0-3-windows-x86_64-setup.exe"
del /f "%yuki%\librewolf-137.0-3-windows-x86_64-setup.exe"
pause
goto GPUDrivers

:BraveBrowser
cls
echo Downloading Brave Browser...
curl -L -o "%yuki%\BraveBrowserSetup-BRV010.exe" "https://laptop-updates.brave.com/download/BRV010?bitness=64"
if %errorlevel% neq 0 (
    echo Failed to download Brave Browser.
    exit /b
)
start "" "%yuki%\BraveBrowserSetup-BRV010.exe"
del /f "%yuki%\BraveBrowserSetup-BRV010.exe"
pause
goto GPUDrivers

REM ============================================================
REM                   GPU Drivers Selection
REM ============================================================
:GPUDrivers
cls
echo Please Select Your GPU Manufacturer:
echo.
echo   1. Nvidia
echo   2. AMD
echo   3. Intel
echo.
choice /C 123 /M "Choose your GPU:"
if errorlevel 3 goto IntelGPU
if errorlevel 2 goto AMDGPU
if errorlevel 1 goto NVGPU

:NVGPU
cls
echo For Nvidia GPUs, please download and run NVCleanstall.
timeout /t 2 /nobreak
start "" "https://www.techpowerup.com/download/techpowerup-nvcleanstall"
timeout /t 3 /nobreak
start "" "%SYSTEMROOT%\Setup\NVCleanstallGuide.txt"
echo Follow the guide for optimal settings.
pause
goto NICDrivers

:AMDGPU
cls
echo For AMD GPUs, please download AMD drivers:
timeout /t 2 /nobreak
start "" "https://github.com/GSDragoon/RadeonSoftwareSlimmer/releases/tag/1.12.0"
start "" "https://www.amd.com/en/support"
echo Optionally experiment with Radeon Slimmer or use the official AMD installer.
pause
goto NICDrivers

:IntelGPU
cls
echo For Intel GPUs, please download the latest Intel drivers:
timeout /t 2 /nobreak
start "" "https://www.intel.com/content/www/us/en/support/articles/000005848/graphics.html"
pause
goto NICDrivers

REM ============================================================
REM         Network Adapter (NIC) Drivers Selection
REM ============================================================
:NICDrivers
cls
echo Please Select Your Network Adapter Manufacturer:
echo.
echo   1. Intel
echo   2. Realtek
echo   3. Killer
echo   4. Broadcom
echo.
choice /C 1234 /M "Choose your NIC manufacturer:"
if errorlevel 4 goto BroadcomNIC
if errorlevel 3 goto KillerNIC
if errorlevel 2 goto RealtekNIC
if errorlevel 1 goto IntelNIC

:IntelNIC
cls
echo For Intel NICs, please download the drivers:
timeout /t 2 /nobreak
start "" "https://www.intel.com/content/www/us/en/download/727998/intel-network-adapter-driver-for-microsoft-windows-11.html"
pause
goto ChipsetDrivers

:RealtekNIC
cls
echo For Realtek NICs, please download the drivers:
timeout /t 2 /nobreak
start "" "https://www.realtek.com/Download/List?cate_id=584"
timeout /t 3 /nobreak
pause
goto ChipsetDrivers

:KillerNIC
cls
echo For Killer NICs, please download the drivers:
timeout /t 2 /nobreak
start "" "https://www.killernetworking.com/driver-downloads"
timeout /t 3 /nobreak
pause
goto ChipsetDrivers

:BroadcomNIC
cls
echo For Broadcom NICs, please download the drivers:
timeout /t 2 /nobreak
start "" "https://www.broadcom.com/support/download-search"
timeout /t 3 /nobreak
pause
goto ChipsetDrivers

REM ============================================================
REM              Chipset Drivers Selection
REM ============================================================
:ChipsetDrivers
cls
echo Please Select Your Chipset Manufacturer:
echo.
echo   1. Intel
echo   2. AMD
echo.
choice /C 12 /M "Choose your chipset manufacturer:"
if errorlevel 2 goto AMDChipset
if errorlevel 1 goto IntelChipset

:IntelChipset
cls
echo For Intel chipsets, please download the drivers:
timeout /t 2 /nobreak
start "" "https://www.intel.com/content/www/us/en/support/articles/000005533/software/chipset-software.html"
timeout /t 3 /nobreak
pause
goto Finished

:AMDChipset
cls
echo For AMD chipsets, please download the drivers:
timeout /t 2 /nobreak
start "" "https://www.amd.com/en/support/chipsets/amd-socket-am4/500-series/500"
timeout /t 3 /nobreak
pause
goto Finished

REM ============================================================
REM           Finished Setup & Restart Prompt
REM ============================================================
:Finished
cls
curl -L -o "%yuki%\YukiTweaks.bat" "https://raw.githubusercontent.com/YukiWasTake/YukiOS/main/files/YukiTweaks.bat"
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /v "Tweaks" /t REG_SZ /d "%yuki%\YukiTweaks.bat" /f

echo Setup Complete. Log file saved at: %logfile%
echo.
timeout /t 3 /nobreak
echo Press any key to restart your computer...
pause >nul
shutdown /r /t 0

:EOF