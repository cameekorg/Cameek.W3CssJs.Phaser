@echo off
@echo.
@echo Download Phaser
@echo ================
@echo https://www.jsdelivr.com/package/npm/phaser
@echo.

:: Shorten the prompt temporarily
@prompt $S

:: Change to the script's directory
@pushd %~dp0

@echo Configuring Version and URLs
@echo ----------------------------
set PHASER_VERSION=3.9.0
set PHASER_BASE_URL=https://cdn.jsdelivr.net/npm/phaser@%PHASER_VERSION%/dist

:: Phaser JS and License URLs
set URL_PHASER=%PHASER_BASE_URL%/phaser.min.js
set URL_LICENSE=https://raw.githubusercontent.com/photonstorm/phaser/v%PHASER_VERSION%/license.txt

@echo.
@echo.

@echo Configuring Target Directories and Files
@echo ----------------------------------------
set TARGET_WWW_DIR=../wwwroot
set TARGET_JS_DIR=%TARGET_WWW_DIR%/js
set TARGET_LICENSE=%TARGET_WWW_DIR%/LICENSE-phaser.txt
set TARGET_PHASER=%TARGET_JS_DIR%/phaser.min.js

@echo.
@echo.

@echo Creating Directories
@echo --------------------
if not exist "%TARGET_JS_DIR%" mkdir "%TARGET_JS_DIR%"
@echo.
@echo.

@echo Downloading Files
@echo -----------------
curl -L -o %TARGET_PHASER% %URL_PHASER%
curl -L -o %TARGET_LICENSE% %URL_LICENSE%

@echo.
@echo.

:: Restore the previous directory
@popd

:: Reset the prompt to the default
@prompt

@echo.
@echo ===================================
@echo Finished downloading Phaser files
@echo.

@pause
