@echo off
title CS2 Borderless Launcher 
color a

:: ==== INFO =====
echo.
echo [CS2-BORDERLESS] This script changes your Windows resolution
echo to match your CS2 in-game resolution for perfect fullscreen
echo borderless experience (no blackbars, no alt-tab bugs).
echo.
echo When CS2 is closed, your native desktop resolution is restored.
echo.

:: ===== DISPLAY HEADER =====
echo ========================================
echo     CS2 BORDERLESS LAUNCHER - eddycohen
echo ========================================
echo.
echo Select your CS2 in-game resolution:
echo.

echo [1] 1920 x 1080   (16:9)
echo [2] 1680 x 1050   (16:10)
echo [3] 1600 x 900    (16:9)
echo [4] 1440 x 1080   (4:3)
echo [5] 1280 x 960    (4:3)
echo [6] 1280 x 720    (16:9)
echo [7] 1024 x 768    (4:3)
echo [8] 800 x 600     (4:3)
echo.

set /p csres=Your CS2 resolution (1-8): 

if "%csres%"=="1" ( set xres=1920 & set yres=1080 )
if "%csres%"=="2" ( set xres=1680 & set yres=1050 )
if "%csres%"=="3" ( set xres=1600 & set yres=900 )
if "%csres%"=="4" ( set xres=1440 & set yres=1080 )
if "%csres%"=="5" ( set xres=1280 & set yres=960 )
if "%csres%"=="6" ( set xres=1280 & set yres=720 )
if "%csres%"=="7" ( set xres=1024 & set yres=768 )
if "%csres%"=="8" ( set xres=800  & set yres=600 )

:: ==== SELECT NATIVE DESKTOP RESOLUTION TO RESTORE ====
cls
color b
echo.
echo What is your normal desktop resolution (after CS2)?
echo.

echo [1] 1920 x 1080
echo [2] 2560 x 1440
echo [3] 1600 x 900
echo [4] 1366 x 768
echo [5] 3840 x 2160
echo [6] 1280 x 1024
echo.

set /p nativeres=Your desktop resolution (1-6): 

if "%nativeres%"=="1" ( set xorig=1920 & set yorig=1080 )
if "%nativeres%"=="2" ( set xorig=2560 & set yorig=1440 )
if "%nativeres%"=="3" ( set xorig=1600 & set yorig=900 )
if "%nativeres%"=="4" ( set xorig=1366 & set yorig=768 )
if "%nativeres%"=="5" ( set xorig=3840 & set yorig=2160 )
if "%nativeres%"=="6" ( set xorig=1280 & set yorig=1024 )

:: ==== APPLY CS2 RESOLUTION ====
cls
color a
echo.
echo [*] Applying CS2 resolution: %xres%x%yres%...
QRes.exe /x:%xres% /y:%yres%

:: ==== LAUNCH CS2 ====
echo [*] Launching CS2...
start steam://rungameid/730

:: ==== WAIT FOR GAME TO START ====
:waitStart
timeout /t 2 >nul
tasklist /fi "imagename eq cs2.exe" | find /i "cs2.exe" >nul
if errorlevel 1 goto waitStart

echo [+] CS2 is running...

:: ==== WAIT FOR GAME TO CLOSE ====
:waitClose
timeout /t 5 >nul
tasklist /fi "imagename eq cs2.exe" | find /i "cs2.exe" >nul
if not errorlevel 1 goto waitClose

:: ==== RESTORE DESKTOP RESOLUTION ====
echo.
echo [*] Restoring desktop resolution: %xorig%x%yorig%...
QRes.exe /x:%xorig% /y:%yorig%

color c
echo [+] Done. Back to native resolution.
timeout /t 2 >nul
exit
