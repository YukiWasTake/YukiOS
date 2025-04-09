@echo off

:: Color
color 70

::UTF-8
chcp 65001 >nul

::Enable Delayed Expansion
SetLocal EnableDelayedExpansion

::Version
set Version=1.0

::Title Of Script
title Yuki OS Tweaks

::Make Directory and Directory Shortcut
if not exist "%UserProfile%\Desktop\YukiTweaks" (
    mkdir "%UserProfile%\Desktop\YukiTweaks"
)
set "yuki=%UserProfile%\Desktop\YukiTweaks" >nul 2>&1

::DevManView Var
set "dev=%yuki%\DevManView.exe /disable"

::Check For Curl
where curl >nul 2>&1
if errorlevel 1 (
    echo "Curl Is Not Installed. Please Install Curl and Try Again."
    pause
    exit /b
)
    ::System Restore Point Creation
    :RestorePoint
    cls
    echo ==================================================================
    echo Would You Like To Create A System Restore Point Before Continuing?
    echo ==================================================================
    echo                            1. Yes
    echo                            2. No
    echo ==================================================================
    set /p choice=Choose option then press Enter:
    if "%choice%"=="1" goto CreateRestorePoint
    if "%choice%"=="2" goto ContinueTweaks

    ::Invalid Choice
    echo Invalid choice...Try Again
    pause
    goto RestorePoint

    :CreateRestorePoint
    cls
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d "0" /f >nul 2>&1
    powershell -ExecutionPolicy Bypass -Command "CheckPoint-Computer -Description 'Yuki Tweaks' -RestorePointType 'MODIFY_SETTINGS'"
    echo ============================
    echo    Restore Point Created
    echo ============================
    echo.
    echo.
    echo ============================
    echo Press Any Key To Continue...
    echo ============================
    pause >nul

    :ContinueTweaks
    cls

    ::CheckForAdmin
    net session >nul 2>&1
    if %errorlevel% neq 0 (
        echo This script requires administrator privileges.
        echo Attempting to relaunch with elevated rights...
        powershell -Command "Start-Process -Verb RunAs -FilePath '%~f0'"
        exit /b
    )
    
    ::Set Execution Policy Temporarily
    powershell -Command "Try {Set-ExecutionPolicy Unrestricted -Scope Process -Force} Catch {}"

    ::Disable LUA
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f >nul 2>&1
    
::Begin Tweaks
echo ===========================
echo    Yuki Tweaks Started
echo ===========================
timeout /t 3 >nul

::Disable Process and Kernel Mitigations
echo Disabling Process And Kernel Mitigations...
powershell -Command "Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\*' -Recurse -ErrorAction SilentlyContinue"
powershell -Command "ForEach($v in (Get-Command -Name 'Set-ProcessMitigation').Parameters['Disable'].Attributes.ValidValues){Set-ProcessMitigation -System -Disable $v.ToString() -ErrorAction SilentlyContinue}"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationOptions" /t REG_BINARY /d 222222222222222222222222222222222222222222222222222222222222222 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationAuditOptions" /t REG_BINARY /d 222222222222222222222222222222222222222222222222222222222222222 /f
cls

::Other Mitigations
echo Disabling Other Mitigations...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "MoveImages" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "KernelSEHOPEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v "DisableExternalDMAUnderLock" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" /v "DEPOff" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoDataExecutionPrevention" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "DisableHHDEP" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d 0 /f >nul 2>&1
timeout /t 2 /nobreak >nul

::File System Changes
echo Optimizing File System...
fsutil behavior set disable8dot3 1 >nul 2>&1
fsutil behavior set disablelastaccess 1 >nul 2>&1
timeout /t 2 /nobreak >nul

::Boot Parameters
echo Boot Parameters...
bcdedit /set isolatedcontext No >nul 2>&1
bcdedit /set allowedinmemorysettings 0x0 >nul 2>&1
bcdedit /set disableelamdrivers Yes >nul 2>&1
bcdedit /set bootmenupolicy Legacy >nul 2>&1
bcdedit /set hypervisorlaunchtype Off >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
timeout /t 2 /nobreak >nul


::Win32PrioritySeparation
echo Setting Win32PrioritySeparation...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "36" /f >nul 2>&1
timeout /t 2 >nul

::Weak Host Model
echo Enabling Weak Host Send and Receive...
powershell -Command "Get-NetAdapter -IncludeHidden | Set-NetIPInterface -WeakHostSend Enabled -WeakHostReceive Enabled -ErrorAction SilentlyContinue"
timeout /t 2 /nobreak >nul

::NX And Virtualization (Valorant And Faceit)
:NXVBS
cls
echo ====================================
echo  Do You Play Valorant And/Or FACEIT?
echo ====================================
echo             1. Yes
echo             2. No
echo ====================================
set /p choice=Choose Your Desired Option Then Press Enter:
if "%choice%"=="1" goto EnableVBS
if "%choice%"=="2" goto DisableVBS

::Invalid Option
echo Invalid Option...Try Again
pause
goto NXVBS

:EnableVBS
cls
echo Enabling VBS And NX...
bcdedit /set nx OptIn >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "WasEnabledBy" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d "1" /f >nul 2>&1
bcdedit /deletevalue vsmlaunchtype >nul 2>&1
timeout /t 2 >nul
goto SvcHostSplitThresholdInKB

:DisableVBS
cls
echo Disabling VBS And NX...
bcdedit /set nx OptOut >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d "0" /f >nul 2>&1
bcdedit /set vsmlaunchtype Off >nul 2>&1
timeout /t 2 >nul
goto SvcHostSplitThresholdInKB


::SvcHostSplitThresholdInKB (No Impact On Performance Just Lowers Process Count)
:SvcHostSplitThresholdInKB
cls 
echo ==========================================
echo       Please Select Your RAM Amount
echo ==========================================
echo         1. 4 GB      5. 16 GB
echo         2. 6 GB      6. 24 GB
echo         3. 8 GB      7. 32 GB
echo         4. 12 GB     8. 64 GB
echo ==========================================
echo * If Other, Choose The Closest Number To *
set /p choice=Choose Your RAM Size:
if "%choice%"=="1" goto 4GB
if "%choice%"=="2" goto 6GB
if "%choice%"=="3" goto 8GB
if "%choice%"=="4" goto 12GB
if "%choice%"=="5" goto 16GB
if "%choice%"=="6" goto 24GB
if "%choice%"=="7" goto 32GB
if "%choice%"=="8" goto 64GB

::Invalid Option
echo Invalid choice.
pause
goto SvcHostSplitThresholdInKB

:4GB
cls
echo SvcHostSplitThresholdInKB 4 GB...
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "4194304" /f >nul 2>&1
timeout /t 2 /nobreak >nul 2>&1
goto Visual

:6GB
cls
echo SvcHostSplitThresholdInKB 6 GB...
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "6291456" /f >nul 2>&1
timeout /t 2 /nobreak >nul 2>&1
goto Visual

:8GB
cls
echo SvcHostSplitThresholdInKB 8 GB...
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "8388608" /f >nul 2>&1
timeout /t 2 /nobreak >nul 2>&1
goto Visual

:12GB
cls
echo SvcHostSplitThresholdInKB 12 GB...
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "12582912" /f >nul 2>&1
timeout /t 2 /nobreak >nul 2>&1
goto Visual

:16GB
cls
echo SvcHostSplitThresholdInKB 16 GB...
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "16777216" /f >nul 2>&1
timeout /t 2 /nobreak >nul 2>&1
goto Visual

:24GB
cls
echo SvcHostSplitThresholdInKB 24 GB...
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "25165824" /f >nul 2>&1
timeout /t 2 /nobreak >nul 2>&1
goto Visual

:32GB
cls
echo SvcHostSplitThresholdInKB 32 GB...
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "33554432" /f >nul 2>&1
timeout /t 2 /nobreak >nul 2>&1
goto Visual

:64GB
cls
echo SvcHostSplitThresholdInKB 64 GB...
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "67108864" /f >nul 2>&1
timeout /t 2 /nobreak >nul 2>&1
goto Visual

::Visual Settings
:Visual
cls
echo =======================
echo Opening Visual Settings
echo =======================
echo.
echo =======================================
echo Set To Performance Or Adjust As Desired
echo =======================================
sysdm.cpl ,3
echo.
echo ============================
echo Press Any Key To Continue...
echo ============================
pause >nul

::OOSU10 Windows Anti-Spy
:OOSU
cls
echo ===========================================================================================
echo Import OOSU Anti-Spy Configuration? (OOSU10 Disables Telemetry and Other Unwanted Features)
echo ===========================================================================================
echo                                         1. Yes
echo                                         2. No
echo ===========================================================================================
set /p choice=Choose Desired Option Then Press Enter: 
if "%choice%"=="1" goto ImportOOSU
if "%choice%"=="2" goto DisableDevices
    
::Invalid Choice
echo Invalid choice.
pause
goto OOSU

::Import OOSU Config
:ImportOOSU
cls
echo ======================================================
echo Downloading OOSU10 and Importing Configuration File...
echo ======================================================
curl -L -o "%yuki%\OOSU10.exe" "https://raw.githubusercontent.com/YukiWasTake/YukiOS/main/files/OOSU10.exe" >nul 2>&1
curl -L -o "%yuki%\ooshutup10.cfg" "https://raw.githubusercontent.com/YukiWasTake/YukiOS/main/files/ooshutup10.cfg" >nul 2>&1
start "" /wait "%yuki%\OOSU10.exe" "%yuki%\ooshutup10.cfg" >nul 2>&1
echo ======================================================
echo              Press Any Key To Continue...
echo ======================================================
pause >nul
    
::Disable Devices
:DisableDevices
cls
echo ===============================
echo Disable Useless System Devices?
echo ===============================
echo            1. Yes
echo            2. No
echo ===============================
set /p choice=Choose option then press Enter: 
if "%choice%"=="1" goto DevicesOff
if "%choice%"=="2" goto PowerStuff
    
::Invalid Choice
echo Invalid choice...Try Again
pause >nul
goto DisableDevices

::Proceed With Disabling Devices
:DevicesOff
cls
echo =========================
echo Downloading DevManView...
echo =========================
curl -L -o "%yuki%\DevManView.exe" "https://raw.githubusercontent.com/YukiWasTake/YukiOS/main/files/DevManView.exe" >nul 2>&1
cls
echo ============================
echo Disabling Useless Devices...
echo ============================
%dev% "Composite Bus Enumerator"
%dev% "System Speaker"
%dev% "Microsoft Virtual Drive Enumerator"
%dev% "Microsoft Hyper-V Virtualization Infrastructure Driver"
%dev% "NDIS Virtual Network Adapter Enumerator"
%dev% "Microsoft Radio Device Enumeration Bus"
%dev% "Microsoft RRAS Root Enumerator"
%dev% "WAN Miniport (IP)"
%dev% "WAN Miniport (IPv6)"
%dev% "WAN Miniport (Network Monitor)"
%dev% "WAN Miniport (PPPOE)"
%dev% "WAN Miniport (SSTP)"
%dev% "WAN Miniport (L2TP)"
%dev% "WAN Miniport (PPTP)"
%dev% "WAN Miniport (IKEv2)"
timeout /t 2 /nobreak >nul

::Power Plan and Driver Power Saving Disable
:PowerStuff
cls
echo ========================
echo Applying Power Tweaks...
echo ======================== 
curl -L -o "%yuki%\yuki.pow" "https://raw.githubusercontent.com/YukiWasTake/YukiOS/main/files/yuki.pow" >nul 2>&1
curl -L -o "%yuki%\disabledriverpowersaving.ps1" "https://raw.githubusercontent.com/YukiWasTake/YukiOS/main/files/disabledriverpowersaving.ps1" >nul 2>&1
powercfg -import "%yuki%\yuki.pow" 7f5875ed-2f22-4ba1-b357-3188ac5702a9 >nul 2>&1
powercfg -setactive 7f5875ed-2f22-4ba1-b357-3188ac5702a9 >nul 2>&1
powercfg -h off >nul 2>&1
start "" /wait powershell -ExecutionPolicy Bypass -File "%yuki%\disabledriverpowersaving.ps1"

::Remove Default Power Plans
powercfg -delete a1841308-3541-4fab-bc81-f71556f20b4a >nul 2>&1
powercfg -delete 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
powercfg -delete e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1

::Nvidia GPU Tweaks
:nvidia
cls
echo ==========================
echo Do you have an Nvidia GPU?
echo ==========================
echo         1. Yes
echo         2. No
echo ==========================
set /p choice=Choose Desired Option Then Press Enter: 
if "%choice%"=="1" goto nvidiatweaks
if "%choice%"=="2" goto finished
echo Invalid choice.
pause
goto nvidia

::NVPI Profile And Disable DynamicPState
:nvidiatweaks
cls
echo =====================================
echo Importing Nvidia Inspector Profile...
echo =====================================
curl -L -o "%yuki%\nvidiaProfileInspector.exe" "https://raw.githubusercontent.com/YukiWasTake/YukiOS/main/files/nvidiaProfileInspector.exe" >nul 2>&1
curl -L -o "%yuki%\yuki.nip" "https://raw.githubusercontent.com/YukiWasTake/YukiOS/main/files/yuki.nip" >nul 2>&1
start "" /wait "%yuki%\nvidiaProfileInspector.exe" "%yuki%\yuki.nip" >nul 2>&1
cls
echo ==========================
echo Disabling DynamicPState...
echo ==========================
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableDynamicPstate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d 1 /f >nul 2>&1
timeout /t 2 /nobreak >nul

::Finished And Launch ReadMe At Next Reboot
:finished
cls
curl -L -o "%yuki%\readme.bat" "https://raw.githubusercontent.com/YukiWasTake/YukiOS/main/files/readme.bat" >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /v "ReadMe" /t REG_SZ /d "%yuki%\readme.bat" /f >nul 2>&1

echo =================
echo  Tweaks Complete 
echo =================
echo.
echo ===========================
echo Press Any Key To Restart...
echo ===========================
pause >nul
shutdown /r /t 0

:EOF



