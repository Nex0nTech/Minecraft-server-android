@echo off
title NexonTech Android Toolkit
setlocal enabledelayedexpansion

:: Start in platform-tools if exists, otherwise Downloads
if exist "%USERPROFILE%\Downloads\platform-tools" (
    cd "%USERPROFILE%\Downloads\platform-tools"
) else (
    cd "%USERPROFILE%\Downloads"
)

:menu
cls
color 09
echo ============================================
echo        NexonTech Android Toolkit
echo ============================================
echo.
echo  1) Install SDK Platform Tools
echo  2) Check ADB connection
echo  3) Reboot to bootloader
echo  4) Reboot to recovery
echo  5) Install APK from PC
echo  6) Uninstall package (debloat)
echo  7) List installed packages
echo  8) Pull file from device
echo  9) Push file to device
echo 10) USB debugging instructions
echo 11) Check Fastboot connection
echo 12) Flash boot.img
echo 13) Flash recovery.img
echo 14) Extract boot.img from payload.bin
echo 15) Show device info
echo 16) Clear ADB keys
echo 17) Restart ADB server
echo 18) Exit
echo.
set /p choice=Select an option:

if "%choice%"=="1" goto f1
if "%choice%"=="2" goto f2
if "%choice%"=="3" goto f3
if "%choice%"=="4" goto f4
if "%choice%"=="5" goto f5
if "%choice%"=="6" goto f6
if "%choice%"=="7" goto f7
if "%choice%"=="8" goto f8
if "%choice%"=="9" goto f9
if "%choice%"=="10" goto f10
if "%choice%"=="11" goto f11
if "%choice%"=="12" goto f12
if "%choice%"=="13" goto f13
if "%choice%"=="14" goto f14
if "%choice%"=="15" goto f15
if "%choice%"=="16" goto f16
if "%choice%"=="17" goto f17
if "%choice%"=="18" exit

goto menu

:: ---------------------------------------------------------
:: 1) Install SDK Platform Tools (MEDIUM - YELLOW)
:f1
cls
color 0E
echo This function installs the Android SDK Platform Tools into Downloads.
echo.
color 0C
echo WARNING: This action will download and extract files on your PC.
echo.
set /p c=Continue (Y/N):
if /I "%c%" NEQ "Y" goto menu

cls
color 0E
echo Downloading Platform Tools...
powershell -command "Invoke-WebRequest 'https://dl.google.com/android/repository/platform-tools-latest-windows.zip' -OutFile 'platform-tools.zip'"

echo Extracting...
powershell -command "Expand-Archive 'platform-tools.zip' -DestinationPath '.' -Force"

del platform-tools.zip

echo Done. Entering platform-tools folder...
cd platform-tools

pause
goto menu

:: ---------------------------------------------------------
:: 2) Check ADB connection (SAFE - GREEN)
:f2
cls
color 0A
echo This function checks if your device is detected by ADB.
echo.
color 0C
echo WARNING: Make sure USB debugging is enabled.
echo.
set /p c=Continue (Y/N):
if /I "%c%" NEQ "Y" goto menu

cls
color 0A
adb devices
pause
cd "%USERPROFILE%\Downloads\platform-tools"
goto menu

:: ---------------------------------------------------------
:: 3) Reboot to bootloader (MEDIUM - YELLOW)
:f3
cls
color 0E
echo This function reboots your device into bootloader mode.
echo.
color 0C
echo WARNING: Device will restart into fastboot mode.
echo.
set /p c=Continue (Y/N):
if /I "%c%" NEQ "Y" goto menu

cls
color 0E
adb reboot bootloader
pause
cd "%USERPROFILE%\Downloads\platform-tools"
goto menu

:: ---------------------------------------------------------
:: 4) Reboot to recovery (SAFE - GREEN)
:f4
cls
color 0A
echo This function reboots your device into recovery mode.
echo.
color 0C
echo WARNING: Device will restart.
echo.
set /p c=Continue (Y/N):
if /I "%c%" NEQ "Y" goto menu

cls
color 0A
adb reboot recovery
pause
cd "%USERPROFILE%\Downloads\platform-tools"
goto menu

:: ---------------------------------------------------------
:: 5) Install APK (MEDIUM - YELLOW)
:f5
cls
color 0E
echo This function installs an APK on your device.
echo.
color 0C
echo WARNING: Installing unknown APKs may be unsafe.
echo.
set /p c=Continue (Y/N):
if /I "%c%" NEQ "Y" goto menu

cls
color 0E
set /p apk=Enter full APK path:
adb install "%apk%"
pause
cd "%USERPROFILE%\Downloads\platform-tools"
goto menu

:: ---------------------------------------------------------
:: 6) Debloat (HIGH - RED)
:f6
cls
color 0C
echo This function uninstalls a package from your device.
echo WARNING: Removing system apps may break your device.
echo.
set /p c=Continue (Y/N):
if /I "%c%" NEQ "Y" goto menu

cls
color 0C
set /p pkg=Enter package name:
adb shell pm uninstall -k --user 0 "%pkg%"
pause
cd "%USERPROFILE%\Downloads\platform-tools"
goto menu

:: ---------------------------------------------------------
:: 7) List packages (SAFE - GREEN)
:f7
cls
color 0A
echo Listing installed packages...
echo.
cls
color 0A
adb shell pm list packages
pause
cd "%USERPROFILE%\Downloads\platform-tools"
goto menu

:: ---------------------------------------------------------
:: 8) Pull file (SAFE - GREEN)
:f8
cls
color 0A
echo Pull a file from device.
echo.
cls
color 0A
set /p src=Device path:
set /p dst=Destination path:
adb pull "%src%" "%dst%"
pause
cd "%USERPROFILE%\Downloads\platform-tools"
goto menu

:: ---------------------------------------------------------
:: 9) Push file (SAFE - GREEN)
:f9
cls
color 0A
echo Push a file to device.
echo.
cls
color 0A
set /p src=Source path:
set /p dst=Device path:
adb push "%src%" "%dst%"
pause
cd "%USERPROFILE%\Downloads\platform-tools"
goto menu

:: ---------------------------------------------------------
:: 10) USB debugging instructions (SAFE)
:f10
cls
color 0A
echo Enable USB debugging:
echo Settings > About phone > Tap Build Number 7 times.
echo Developer Options > USB Debugging.
pause
cd "%USERPROFILE%\Downloads\platform-tools"
goto menu

:: ---------------------------------------------------------
:: 11) Check Fastboot (SAFE)
:f11
cls
color 0A
fastboot devices
pause
cd "%USERPROFILE%\Downloads\platform-tools"
goto menu

:: ---------------------------------------------------------
:: 12) Flash boot.img (HIGH - RED)
:f12
cls
color 0C
echo Flash boot.img to device.
echo WARNING: Wrong file = bootloop.
echo.
set /p c=Continue (Y/N):
if /I "%c%" NEQ "Y" goto menu

cls
color 0C
set /p img=Enter boot.img path:
fastboot flash boot "%img%"
pause
cd "%USERPROFILE%\Downloads\platform-tools"
goto menu

:: ---------------------------------------------------------
:: 13) Flash recovery.img (HIGH - RED)
:f13
cls
color 0C
echo Flash recovery.img to device.
echo WARNING: Wrong file = brick.
echo.
set /p c=Continue (Y/N):
if /I "%c%" NEQ "Y" goto menu

cls
color 0C
set /p img=Enter recovery.img path:
fastboot flash recovery "%img%"
pause
cd "%USERPROFILE%\Downloads\platform-tools"
goto menu

:: ---------------------------------------------------------
:: 14) Extract boot.img from payload.bin (MEDIUM)
:f14
cls
color 0E
echo This requires payload-dumper.
pause
cd "%USERPROFILE%\Downloads\platform-tools"
goto menu

:: ---------------------------------------------------------
:: 15) Device info (SAFE)
:f15
cls
color 0A
adb shell getprop
pause
cd "%USERPROFILE%\Downloads\platform-tools"
goto menu

:: ---------------------------------------------------------
:: 16) Clear ADB keys (SAFE)
:f16
cls
color 0A
adb kill-server
del %USERPROFILE%\.android\adbkey
del %USERPROFILE%\.android\adbkey.pub
adb start-server
pause
cd "%USERPROFILE%\Downloads\platform-tools"
goto menu

:: ---------------------------------------------------------
:: 17) Restart ADB server (SAFE)
:f17
cls
color 0A
adb kill-server
adb start-server
pause
cd "%USERPROFILE%\Downloads\platform-tools"
goto menu
