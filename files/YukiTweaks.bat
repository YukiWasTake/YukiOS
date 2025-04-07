@echo off
REM ============================================================
REM                  Yuki Tweaks Script
REM ============================================================

REM Set display color and character encoding to UTF-8
color 9F
chcp 65001 >nul

REM Set title
title Yuki OS Tweaks

REM ------------------------------------------------------------
REM          Create Working Directory and Log File
REM ------------------------------------------------------------
if not exist "%UserProfile%\Desktop\YukiTweaks" (
    mkdir "%UserProfile%\Desktop\YukiTweaks"
)
set "yuki=%UserProfile%\Desktop\YukiTweaks"
set "logfile=%yuki%\YukiTweaks.log"

(
    REM ------------------------------------------------------------
    REM          Check for Administrator Privileges
    REM ------------------------------------------------------------
    net session >nul 2>&1
    if %errorlevel% neq 0 (
        echo This script requires administrator privileges.
        echo Attempting to relaunch with elevated rights...
        powershell -Command "Start-Process -Verb RunAs -FilePath '%~f0'"
        exit /b
    )
    
    REM ------------------------------------------------------------
    REM                  DevManView Variable
    REM ------------------------------------------------------------
    set "dev=%yuki%\DevManView.exe /disable"
    
    REM ============================================================
    REM             System Restore Point Prompt
    REM ============================================================
    :RestorePoint
    cls
    echo Would you like to create a System Restore Point before continuing?
    echo.
    echo   1. Yes
    echo   2. No
    echo.
    set /p choice=Choose option then press Enter: 
    if "%choice%"=="1" goto CreateRestore
    if "%choice%"=="2" goto ContinueTweaks
    echo Invalid choice.
    pause
    goto RestorePoint

    :CreateRestore
    cls
    powershell -Command "Checkpoint-Computer -Description 'Yuki Tweaks Restore Point' -RestorePointType 'MODIFY_SETTINGS'"
    echo Restore point created.
    pause

    :ContinueTweaks
    REM ------------------------------------------------------------
    REM               Set Execution Policy Temporarily
    REM ------------------------------------------------------------
    powershell -Command "Try {Set-ExecutionPolicy Unrestricted -Scope Process -Force} Catch {}"

    echo === Yuki OS Tweaks Started ===
    echo.

    REM ============================================================
    REM             Process and Kernel Mitigations
    REM ============================================================
    echo Disabling Process Mitigations...
    powershell -Command "Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\*' -Recurse -ErrorAction SilentlyContinue"
    powershell -Command "ForEach($v in (Get-Command -Name 'Set-ProcessMitigation').Parameters['Disable'].Attributes.ValidValues){Set-ProcessMitigation -System -Disable $v.ToString() -ErrorAction SilentlyContinue}"
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationOptions" /t REG_BINARY /d 222222222222222222222222222222222222222222222222222222222222222 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationAuditOptions" /t REG_BINARY /d 222222222222222222222222222222222222222222222222222222222222222 /f
    timeout /t 2 /nobreak

    REM ============================================================
    REM                   Other Mitigations
    REM ============================================================
    echo Disabling Other Mitigations...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "MoveImages" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d 3 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d 3 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "KernelSEHOPEnabled" /t REG_DWORD /d 0 /f
    reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v "DisableExternalDMAUnderLock" /t REG_DWORD /d 0 /f
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d 0 /f
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" /v "DEPOff" /t REG_DWORD /d 1 /f
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoDataExecutionPrevention" /t REG_DWORD /d 1 /f
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "DisableHHDEP" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d 0 /f
    timeout /t 2 /nobreak

    REM ============================================================
    REM                  File System Changes
    REM ============================================================
    echo Optimizing File System for SSD...
    fsutil behavior set disable8dot3 1
    fsutil behavior set disablelastaccess 1
    timeout /t 2 /nobreak

    REM ============================================================
    REM                  Boot Parameters
    REM ============================================================
    echo Boot Settings...
    bcdedit /set isolatedcontext No
    bcdedit /set allowedinmemorysettings 0x0
    bcdedit /set disableelamdrivers Yes
    bcdedit /set vsmlaunchtype Off
    bcdedit /set bootmenupolicy Legacy
    bcdedit /set nx alwaysoff
    bcdedit /set hypervisorlaunchtype Off
    bcdedit /set disabledynamictick yes
    timeout /t 2 /nobreak

    REM ============================================================
    REM              Weak Host Model Settings
    REM ============================================================
    echo Enabling Weak Host Send and Receive...
    powershell -Command "Get-NetAdapter -IncludeHidden | Set-NetIPInterface -WeakHostSend Enabled -WeakHostReceive Enabled -ErrorAction SilentlyContinue"
    timeout /t 2 /nobreak

    REM ============================================================
    REM                  Visual Settings
    REM ============================================================
    echo Opening Visual Settings Panel.
    echo Adjust Performance Settings as desired.
    sysdm.cpl ,3
    echo Click on Performance Settings and change the appearance to Performance or adjust to your liking.
    pause

    REM ============================================================
    REM                        OOSU
    REM ============================================================
    :OOSU
    cls
    echo Import OOSU Anti-Spy Configuration? (OOSU10 disables telemetry and other unwanted features)
    echo.
    echo   1. Yes
    echo   2. No
    echo.
    set /p choice=Choose option: 
    if "%choice%"=="1" goto ImportOOSU
    if "%choice%"=="2" goto DisableDevices
    echo Invalid choice.
    pause
    goto OOSU

    :ImportOOSU
    cls
    echo Downloading OOSU10 and configuration file...
    curl -L -o "%yuki%\OOSU10.exe" "https://raw.githubusercontent.com/YukiWasTake/YukiOS/main/files/OOSU10.exe"
    curl -L -o "%yuki%\ooshutup10.cfg" "https://raw.githubusercontent.com/YukiWasTake/YukiOS/main/files/ooshutup10.cfg"
    start "" /wait "%yuki%\OOSU10.exe" "%yuki%\ooshutup10.cfg"
    pause

    REM ============================================================
    REM                 Disable Devices
    REM ============================================================
    :DisableDevices
    cls
    echo Disable Useless System Devices?
    echo.
    echo   1. Yes
    echo   2. No
    echo.
    set /p choice=Choose option then press Enter: 
    if "%choice%"=="1" goto DevicesOff
    if "%choice%"=="2" goto PowerStuff
    echo Invalid choice.
    pause
    goto DisableDevices

    :DevicesOff
    cls
    echo Downloading DevManView...
    curl -L -o "%yuki%\DevManView.exe" "https://raw.githubusercontent.com/YukiWasTake/YukiOS/main/files/DevManView.exe"
    cls
    echo Disabling Useless Devices...
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
    timeout /t 2 /nobreak

    REM ============================================================
    REM     Power Plan and Driver Power Saving Disable
    REM ============================================================
    :PowerStuff
    cls
    echo Applying Power Tweaks...
    curl -L -o "%yuki%\yuki.pow" "https://raw.githubusercontent.com/YukiWasTake/YukiOS/main/files/yuki.pow"
    curl -L -o "%yuki%\disabledriverpowersaving.ps1" "https://raw.githubusercontent.com/YukiWasTake/YukiOS/main/files/disabledriverpowersaving.ps1"
    powercfg -import "%yuki%\yuki.pow" 7f5875ed-2f22-4ba1-b357-3188ac5702a9
    powercfg -setactive 7f5875ed-2f22-4ba1-b357-3188ac5702a9
    powercfg -h off
    start "" /wait powershell -ExecutionPolicy Bypass -File "%yuki%\disabledriverpowersaving.ps1"

    REM Remove Default Power Plans
    powercfg -delete a1841308-3541-4fab-bc81-f71556f20b4a
    powercfg -delete 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    powercfg -delete e9a42b02-d5df-448d-aa00-03f14749eb61

    REM ============================================================
    REM                Nvidia GPU Tweaks
    REM ============================================================
    :nvidia
    cls
    echo Do you have an Nvidia GPU?
    echo.
    echo   1. Yes
    echo   2. No
    echo.
    set /p choice=Choose option then press Enter: 
    if "%choice%"=="1" goto nvidiatweaks
    if "%choice%"=="2" goto finished
    echo Invalid choice.
    pause
    goto nvidia

    :nvidiatweaks
    cls
    echo Downloading Nvidia Profile Inspector...
    curl -L -o "%yuki%\nvidiaProfileInspector.zip" "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/latest/download/nvidiaProfileInspector.zip"
    powershell -NoProfile Expand-Archive "%yuki%\nvidiaProfileInspector.zip" -DestinationPath "%yuki%\NvidiaProfileInspector\"
    curl -L -o "%yuki%\yuki.nip" "https://raw.githubusercontent.com/YukiWasTake/YukiOS/main/files/yuki.nip"
    start "" /wait "%yuki%\NvidiaProfileInspector\nvidiaProfileInspector.exe" "%yuki%\yuki.nip"
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableDynamicPstate" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d 1 /f
    timeout /t 2 /nobreak

    :finished
    cls
    REM ============================================================
    REM             Launch Readme at Next Reboot
    REM ============================================================
    curl -L -o "%yuki%\readme.bat" "https://raw.githubusercontent.com/YukiWasTake/YukiOS/main/files/readme.bat"
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /v "ReadMe" /t REG_SZ /d "%yuki%\readme.bat" /f

    echo === Tweaks Complete ===

) >> "%logfile%" 2>&1

echo.
echo Log File: %logfile%
echo.
echo === Press Any Key To Restart ===
pause >nul
shutdown /r /t 0

:EOF



