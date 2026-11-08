@echo off
setlocal EnableExtensions

rem Keep this version aligned with the bundled upstream assets.
set "PHASER_VERSION=3.90.0"
set "PHASER_BASE_URL=https://cdn.jsdelivr.net/npm/phaser@%PHASER_VERSION%"
set "TARGET_WWW_DIR=%~dp0..\wwwroot"
set "DOWNLOAD_DIR=%TEMP%\cameek-phaser-%RANDOM%-%RANDOM%-%RANDOM%"
if exist "%DOWNLOAD_DIR%" exit /b 1
mkdir "%DOWNLOAD_DIR%" || exit /b 1

echo Downloading Phaser %PHASER_VERSION% assets and license...
curl --fail --show-error --location "%PHASER_BASE_URL%/dist/phaser.min.js" --output "%DOWNLOAD_DIR%\phaser.min.js"
if errorlevel 1 goto :error
curl --fail --show-error --location "%PHASER_BASE_URL%/LICENSE.md" --output "%DOWNLOAD_DIR%\LICENSE-phaser.txt"
if errorlevel 1 goto :error

rem Update the package only after both downloads have succeeded.
if not exist "%TARGET_WWW_DIR%\js" mkdir "%TARGET_WWW_DIR%\js"
if errorlevel 1 goto :error
move /y "%DOWNLOAD_DIR%\phaser.min.js" "%TARGET_WWW_DIR%\js\phaser.min.js" >nul
if errorlevel 1 goto :error
move /y "%DOWNLOAD_DIR%\LICENSE-phaser.txt" "%TARGET_WWW_DIR%\LICENSE-phaser.txt" >nul
if errorlevel 1 goto :error
rmdir /s /q "%DOWNLOAD_DIR%"
echo Downloaded Phaser %PHASER_VERSION% to %TARGET_WWW_DIR%
exit /b 0

:error
rmdir /s /q "%DOWNLOAD_DIR%"
exit /b 1
