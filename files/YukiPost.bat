@echo off

::Yuki Setup Script

::Version
Set Version=1.0

::Color
color 9F

::UTF-8
chcp 65001 >nul

::Set Title
Title YukiPost

::Enable Delayed Expansion
SetLocal EnableDelayedExpansion

::Check For Curl
where curl >nul 2>&1
if errorlevel 1 (
    echo "curl is not installed. Please install curl and try again."
    pause
    exit /b
)

::Create Working Directory
mkdir "%userprofile%\Desktop\YukiPost"
set "yuki=%userprofile%\Desktop\YukiPost"

::Initial Message
cls
echo =====================================
echo            Setup Started
echo =====================================================================
echo Please Make Sure You Are Connected To The Internet Before Proceeding.
echo =====================================================================
timeout /t 3 /nobreak
echo ============================
echo Press Any Key To Continue...
echo ============================
pause >nul

::Time Zone Selection
:TimeSelect
cls
echo                          Please Select Your Time Zone:
echo  ==================================================================================
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
echo  ===================================================================================
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

::Invalid Selection
echo Invalid Choice... Try Again.
timeout /t 2 /nobreak >nul
pause
goto TimeSelect

::Time Zone Setting Sections
:EST
cls
echo ===================================================
echo Setting Time Zone To Eastern Standard Time (EST)...
echo ===================================================
tzutil /s "Eastern Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:CSTUS
cls
echo ======================================================
echo Setting Time Zone To Central Standard Time (CST-US)...
echo ======================================================
tzutil /s "Central Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:MST
cls
echo ====================================================
echo Setting Time Zone To Mountain Standard Time (MST)...
echo ====================================================
tzutil /s "Mountain Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:PST
cls
echo ===================================================
echo Setting Time Zone To Pacific Standard Time (PST)...
echo ===================================================
tzutil /s "Pacific Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:GMT
cls
echo =================================================
echo Setting Time Zone To Greenwich Mean Time (GMT)...
echo =================================================
tzutil /s "GMT Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:CET
cls
echo ===================================================
echo Setting Time Zone To Central European Time (CET)...
echo ===================================================
tzutil /s "Central European Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:IST
cls
echo =================================================
echo Setting Time Zone To India Standard Time (IST)...
echo =================================================
tzutil /s "India Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:CSTCN
cls
echo ====================================================
echo Setting Time Zone To China Standard Time (CST-CN)...
echo ====================================================
tzutil /s "China Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:JST
cls
echo =================================================
echo Setting Time Zone To Japan Standard Time (JST)...
echo =================================================
tzutil /s "Tokyo Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:AST
cls
echo ====================================================
echo Setting Time Zone To Atlantic Standard Time (AST)...
echo ====================================================
tzutil /s "Atlantic Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:NST
cls
echo ========================================================
echo Setting Time Zone To Newfoundland Standard Time (NST)...
echo ========================================================
tzutil /s "Newfoundland Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:WET
cls
echo ===================================================
echo Setting Time Zone To Western European Time (WET)...
echo ===================================================
tzutil /s "W. Europe Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:EET
cls
echo ===================================================
echo Setting Time Zone To Eastern European Time (EET)...
echo ===================================================
tzutil /s "E. Europe Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:MSK
cls
echo ==================================================
echo Setting Time Zone To Moscow Standard Time (MSK)...
echo ==================================================
tzutil /s "Russian Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:UTC
cls
echo ========================================================
echo Setting Time Zone To Universal Time Coordinated (UTC)...
echo ========================================================
tzutil /s "UTC"
net start w32time
w32tm /resync
goto Install7zip

:HAST
cls
echo ============================================================
echo Setting Time Zone To Hawaii-Aleutian Standard Time (HAST)...
echo ============================================================
tzutil /s "Hawaiian Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:AKST
cls
echo ===================================================
echo Setting Time Zone To Alaska Standard Time (AKST)...
echo ===================================================
tzutil /s "Alaskan Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:ADT
cls
echo ====================================================
echo Setting Time Zone To Atlantic Daylight Time (ADT)...
echo ====================================================
tzutil /s "Atlantic Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:WAST
cls
echo ===============================================================
echo Setting Time Zone To Western Australian Standard Time (WAST)...
echo ===============================================================
tzutil /s "W. Australia Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:KST
cls
echo =================================================
echo Setting Time Zone To Korea Standard Time (KST)...
echo =================================================
tzutil /s "Korea Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:AEST
cls
echo ===============================================================
echo Setting Time Zone To Australian Eastern Standard Time (AEST)...
echo ===============================================================
tzutil /s "AUS Eastern Standard Time"
net start w32time
w32tm /resync
goto Install7zip

:OtherTimeZone
cls
echo =============================
echo Opening Time Zone Settings...
echo =============================
timedate.cpl ,3
echo =================================================================
echo Please Change The Time Zone To Yours And Click "OK" Then "Apply".
echo =================================================================
pause >nul
goto Install7zip

::Install 7zip
:Install7zip
cls
echo ===================
echo Downloading 7zip...
echo ===================
curl -L -o "%yuki%\7z2201-x64.exe" "https://www.7-zip.org/a/7z2201-x64.exe"
cls
start "" /wait "%yuki%\7z2201-x64.exe" /S
del /f "%yuki%\7z2201-x64.exe"
echo 7zip download and installation complete.
timeout /t 2 /nobreak

::Install Visual C++ Redistributable
cls
echo ==========================================
echo Downloading Visual C++ Redistributable...
echo ==========================================
curl -L -o "%yuki%\vcredist_x64.exe" "https://aka.ms/vs/17/release/vc_redist.x64.exe"
start "" /wait "%yuki%\vcredist_x64.exe" /S
del /f "%yuki%\vcredist_x64.exe"
timeout /t 2 /nobreak

::Install .NET Runtimes
cls
echo ==============================
echo Installing .NET 5.0 Runtime...
echo ==============================
curl -L -o "%yuki%\aspnetcore-runtime-5.0.17-win-x64.exe" "https://download.visualstudio.microsoft.com/download/pr/3789ec90-2717-424f-8b9c-3adbbcea6c16/2085cc5ff077b8789ff938015392e406/aspnetcore-runtime-5.0.17-win-x64.exe"
start "" /wait "%yuki%\aspnetcore-runtime-5.0.17-win-x64.exe" /S
del "%yuki%\aspnetcore-runtime-5.0.17-win-x64.exe"

curl -L -o "%yuki%\aspnetcore-runtime-5.0.17-win-x86.exe" "https://download.visualstudio.microsoft.com/download/pr/4bfa247d-321d-4b29-a34b-62320849059b/8df7a17d9aad4044efe9b5b1c423e82c/aspnetcore-runtime-5.0.17-win-x86.exe"
start "" /wait "%yuki%\aspnetcore-runtime-5.0.17-win-x86.exe" /S
del "%yuki%\aspnetcore-runtime-5.0.17-win-x86.exe"

cls
echo ==============================
echo Installing .NET 6.0 Runtime...
echo ==============================
curl -L -o "%yuki%\windowsdesktop-runtime-6.0.36-win-x64.exe" "https://download.visualstudio.microsoft.com/download/pr/f6b6c5dc-e02d-4738-9559-296e938dabcb/b66d365729359df8e8ea131197715076/windowsdesktop-runtime-6.0.36-win-x64.exe"
start "" /wait "%yuki%\windowsdesktop-runtime-6.0.36-win-x64.exe" /S
del "%yuki%\windowsdesktop-runtime-6.0.36-win-x64.exe"

curl -L -o "%yuki%\windowsdesktop-runtime-6.0.36-win-x86.exe" "https://download.visualstudio.microsoft.com/download/pr/cdc314df-4a4c-4709-868d-b974f336f77f/acd5ab7637e456c8a3aa667661324f6d/windowsdesktop-runtime-6.0.36-win-x86.exe"
start "" /wait "%yuki%\windowsdesktop-runtime-6.0.36-win-x86.exe" /S
del "%yuki%\windowsdesktop-runtime-6.0.36-win-x86.exe"

cls
echo ==============================
echo Installing .NET 7.0 Runtime...
echo ==============================
curl -L -o "%yuki%\windowsdesktop-runtime-7.0.20-win-x64.exe" "https://download.visualstudio.microsoft.com/download/pr/08bbfe8f-812d-479f-803b-23ea0bffce47/c320e4b037f3e92ab7ea92c3d7ea3ca1/windowsdesktop-runtime-7.0.20-win-x64.exe"
start "" /wait "%yuki%\windowsdesktop-runtime-7.0.20-win-x64.exe" /S
del "%yuki%\windowsdesktop-runtime-7.0.20-win-x64.exe"

curl -L -o "%yuki%\windowsdesktop-runtime-7.0.20-win-x86.exe" "https://download.visualstudio.microsoft.com/download/pr/b840017b-c69f-4724-a152-11020a0039e6/b74aa12e4ee765a3387a7dcd4ba56187/windowsdesktop-runtime-7.0.20-win-x86.exe"
start "" /wait "%yuki%\windowsdesktop-runtime-7.0.20-win-x86.exe" /S
del "%yuki%\windowsdesktop-runtime-7.0.20-win-x86.exe"

cls
echo ==============================
echo Installing .NET 8.0 Runtime...
echo ==============================
curl -L -o "%yuki%\windowsdesktop-runtime-8.0.11-win-x64.exe" "https://download.visualstudio.microsoft.com/download/pr/27bcdd70-ce64-4049-ba24-2b14f9267729/d4a435e55182ce5424a7204c2cf2b3ea/windowsdesktop-runtime-8.0.11-win-x64.exe"
start "" /wait "%yuki%\windowsdesktop-runtime-8.0.11-win-x64.exe" /S
del "%yuki%\windowsdesktop-runtime-8.0.11-win-x64.exe"

curl -L -o "%yuki%\windowsdesktop-runtime-8.0.11-win-x86.exe" "https://download.visualstudio.microsoft.com/download/pr/6e1f5faf-ee7d-4db0-9111-9e270a458342/4cdcd1af2d6914134308630f048fbdfc/windowsdesktop-runtime-8.0.11-win-x86.exe"
start "" /wait "%yuki%\windowsdesktop-runtime-8.0.11-win-x86.exe" /S
del "%yuki%\windowsdesktop-runtime-8.0.11-win-x86.exe"

cls
echo ==============================
echo Installing .NET 9.0 Runtime...
echo ==============================
curl -L -o "%yuki%\windowsdesktop-runtime-9.0.0-win-x64.exe" "https://download.visualstudio.microsoft.com/download/pr/685792b6-4827-4dca-a971-bce5d7905170/1bf61b02151bc56e763dc711e45f0e1e/windowsdesktop-runtime-9.0.0-win-x64.exe"
start "" /wait "%yuki%\windowsdesktop-runtime-9.0.0-win-x64.exe" /S
del "%yuki%\windowsdesktop-runtime-9.0.0-win-x64.exe"

curl -L -o "%yuki%\windowsdesktop-runtime-9.0.0-win-x86.exe" "https://download.visualstudio.microsoft.com/download/pr/8dfbde7b-c316-418d-934a-d3246253f342/69c6a35b77a4f01b95588e1df2bddf9a/windowsdesktop-runtime-9.0.0-win-x86.exe"
start "" /wait "%yuki%\windowsdesktop-runtime-9.0.0-win-x86.exe" /S
del "%yuki%\windowsdesktop-runtime-9.0.0-win-x86.exe"

::Install DirectX
cls
echo =====================
echo Installing DirectX...
echo =====================
curl -L -o "%yuki%\directx_Jun2010_redist.exe" "https://download.microsoft.com/download/8/4/a/84a35bf1-dafe-4ae8-82af-ad2ae20b6b14/directx_Jun2010_redist.exe"
cls
start "" "%yuki%\directx_Jun2010_redist.exe"
echo ====================================
echo Please accept the license agreement.
echo Then click Browse, select the "%userprofile%" folder, and click OK.
echo ===================================================================
echo                Press Any Key To Continue...
echo ===================================================================
pause >nul
start "" /wait "%userprofile%\DXSetup.exe"
cls
del /f "%yuki%\directx_Jun2010_redist.exe"
echo ==============================
echo DirectX installation complete.
echo ==============================

::Browser Selection
:BrowserSelect
cls
echo ===================================
echo Select the Web Browser you prefer:
echo ===================================
echo   1. Thorium (Anti-Spy Chrome)
echo   2. Librewolf (Anti-Spy Firefox)
echo   3. Brave
echo ===================================
set /p choice=Choose Your Desired Web Browser:
if "%choice%"=="1" goto ThoriumBrowser
if "%choice%"=="2" goto LibrewolfBrowser
if "%choice%"=="3" goto BraveBrowser

::Invalid Selection
echo Invalid Choice... Try Again.
timeout /t 2 /nobreak >nul
pause
goto BrowserSelect

::Browser Installation Sections
:ThoriumBrowser
cls
echo ==============================
echo Downloading Thorium Browser...
echo ==============================
curl -L -o "%yuki%\thorium_AVX2_mini_installer.exe" "https://github.com/Alex313031/Thorium-Win/releases/download/M121.0.6167.204/thorium_AVX2_mini_installer.exe"
start "" "%yuki%\thorium_AVX2_mini_installer.exe"
del /f "%yuki%\thorium_AVX2_mini_installer.exe"
echo ============================
echo Press Any Key To Continue...
echo ============================
pause >nul
goto GPUDrivers

:LibrewolfBrowser
cls
echo ==============================
echo Downloading Librewolf Browser...
echo ==============================
curl -L -o "%yuki%\librewolf-137.0-3-windows-x86_64-setup.exe" "https://gitlab.com/api/v4/projects/44042130/packages/generic/librewolf/137.0-3/librewolf-137.0-3-windows-x86_64-setup.exe"
start "" "%yuki%\librewolf-137.0-3-windows-x86_64-setup.exe"
del /f "%yuki%\librewolf-137.0-3-windows-x86_64-setup.exe"
echo ============================
echo Press Any Key To Continue...
echo ============================
pause >nul
goto GPUDrivers

:BraveBrowser
cls
echo ==============================
echo Downloading Brave Browser...
echo ==============================
curl -L -o "%yuki%\BraveBrowserSetup-BRV010.exe" "https://laptop-updates.brave.com/download/BRV010?bitness=64"
start "" "%yuki%\BraveBrowserSetup-BRV010.exe"
del /f "%yuki%\BraveBrowserSetup-BRV010.exe"
echo ============================
echo Press Any Key To Continue...
echo ============================
pause >nul
goto GPUDrivers

::GPU Drivers Selection
:GPUDrivers
cls
echo ====================================
echo Please Select Your GPU Manufacturer:
echo ====================================
echo            1. Nvidia
echo            2. AMD
echo            3. Intel
echo ====================================
set /p choice=Choose Your GPU Then Press Enter:
if "%choice%"=="1" goto NVGPU
if "%choice%"=="2" goto AMDGPU
if "%choice%"=="3" goto IntelGPU

::Invalid Selection
echo Invalid Choice... Try Again.
timeout /t 2 /nobreak >nul
pause
goto GPUDrivers

:NVGPU
cls
curl -L -o "%yuki%\NVCleanstallGuide.txt" "https://raw.githubusercontent.com/YukiWasTake/YukiOS/main/files/NVCleanstallGuide.txt"
echo ======================================================
echo For Nvidia GPUs, Please Download And Run NVCleanstall.
echo ======================================================
timeout /t 2 /nobreak
start "" "https://www.techpowerup.com/download/techpowerup-nvcleanstall"
timeout /t 3 /nobreak
cls
start "" "%yuki%\NVCleanstallGuide.txt"
echo ======================================
echo Follow the guide for optimal settings.
echo ======================================
echo Press Any Key To Continue...
echo ============================
pause >nul
goto NICDrivers

:AMDGPU
cls
echo ==========================================
echo For AMD GPUs, Please Download AMD Drivers:
echo ==========================================
timeout /t 2 /nobreak
start "" "https://github.com/GSDragoon/RadeonSoftwareSlimmer/releases/tag/1.12.0"
start "" "https://www.amd.com/en/support"
echo Optionally experiment with Radeon Slimmer or use the official AMD installer.
echo ============================
echo Press Any Key To Continue...
echo ============================
pause >nul
goto NICDrivers

:IntelGPU
cls
echo ============================================
echo For Intel GPUs, Please Download The Drivers:
echo ============================================
timeout /t 2 /nobreak
start "" "https://www.intel.com/content/www/us/en/support/articles/000005848/graphics.html"
echo ============================
echo Press Any Key To Continue...
echo ============================
pause >nul
goto NICDrivers


::Network Adapter (NIC) Drivers Selection
:NICDrivers
cls
echo ================================================
echo Please Select Your Network Adapter Manufacturer:
echo ================================================
echo                   1. Intel
echo                   2. Realtek
echo                   3. Killer
echo                   4. Broadcom
echo ================================================
set /p choice=Choose Your Network Adapter Manufacturer Then Press Enter:
if "%choice%"=="1" goto IntelNIC
if "%choice%"=="2" goto RealtekNIC
if "%choice%"=="3" goto KillerNIC
if "%choice%"=="4" goto BroadcomNIC

::Invalid Selection
echo Invalid Choice... Try Again.
timeout /t 2 /nobreak >nul
pause
goto NICDrivers

:IntelNIC
cls
echo ============================================
echo For Intel NICs, Please Download The Drivers:
echo ============================================
timeout /t 2 /nobreak
start "" "https://www.intel.com/content/www/us/en/download/727998/intel-network-adapter-driver-for-microsoft-windows-11.html"
echo ============================
echo Press Any Key To Continue...
echo ============================
pause >nul
goto ChipsetDrivers

:RealtekNIC
cls
echo ==============================================
echo For Realtek NICs, Please Download The Drivers:
echo ==============================================
timeout /t 2 /nobreak
start "" "https://www.realtek.com/Download/List?cate_id=584"
timeout /t 3 /nobreak
echo ============================
echo Press Any Key To Continue...
echo ============================
pause >nul
goto ChipsetDrivers

:KillerNIC
cls
echo =============================================
echo For Killer NICs, Please Download The Drivers:
echo =============================================
timeout /t 2 /nobreak
start "" "https://www.killernetworking.com/driver-downloads"
timeout /t 3 /nobreak
echo ============================
echo Press Any Key To Continue...
echo ============================
pause >nul
goto ChipsetDrivers

:BroadcomNIC
cls
echo ===============================================
echo For Broadcom NICs, Please Download The Drivers:
echo ===============================================
timeout /t 2 /nobreak
start "" "https://www.broadcom.com/support/download-search"
timeout /t 3 /nobreak
echo ============================
echo Press Any Key To Continue...
echo ============================
pause >nul
goto ChipsetDrivers


::Chipset Drivers Selection
:ChipsetDrivers
cls
echo ====================================
echo Please Select Your CPU Manufacturer:
echo ====================================
echo              1. Intel
echo              2. AMD
echo ====================================
set /p choice=Choose Your CPU Then Press Enter:
if "%choice%"=="1" goto IntelChipset
if "%choice%"=="2" goto AMDChipset

::Invalid Selection
echo Invalid Choice... Try Again.
timeout /t 2 /nobreak >nul
pause
goto ChipsetDrivers

:IntelChipset
cls
echo ================================================
echo For Intel Chipsets, Please Download The Drivers:
echo ================================================
timeout /t 2 /nobreak
start "" "https://www.intel.com/content/www/us/en/support/articles/000005533/software/chipset-software.html"
timeout /t 3 /nobreak
echo ============================
echo Press Any Key To Continue...
echo ============================
pause >nul
goto Finished

:AMDChipset
cls
echo ==============================================
echo For AMD Chipsets, Please Download The Drivers:
echo ==============================================
timeout /t 2 /nobreak
start "" "https://www.amd.com/en/support/chipsets/amd-socket-am4/500-series/500"
timeout /t 3 /nobreak
echo ============================
echo Press Any Key To Continue...
echo ============================
pause >nul
goto Finished

::Finished Setup & Restart Prompt
:Finished
cls
curl -L -o "%yuki%\YukiTweaks.bat" "https://raw.githubusercontent.com/YukiWasTake/YukiOS/main/files/YukiTweaks.bat"
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /v "Tweaks" /t REG_SZ /d "%yuki%\YukiTweaks.bat" /f
cls
echo ==============
echo Setup Complete
echo ==============
timeout /t 3 /nobreak
echo =========================================
echo Press any key to restart your computer...
echo =========================================
pause >nul
shutdown /r /t 0

:EOF