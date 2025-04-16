@echo off
color 70

::Delete Temp Folder
echo Deleting Temp Folder...
rmdir /s /q "%temp%\YukiTweaks"

::Launches my github repo for this on reboot (if you found me through discord)
start "" "https://github.com/YukiWasTake/YukiOS"
exit
