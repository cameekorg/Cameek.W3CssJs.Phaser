#!/bin/bash

echo
echo "Download Phaser"
echo "==============="
echo "https://www.jsdelivr.com/package/npm/phaser"
echo

# Change directory to the script's location
cd "$(dirname "$0")" || exit

echo "Configuring Version and URLs"
echo "----------------------------"
PHASER_VERSION="3.90.0"
PHASER_BASE_URL="https://cdn.jsdelivr.net/npm/phaser@${PHASER_VERSION}/dist"

# JS and License
URL_PHASER="${PHASER_BASE_URL}/phaser.min.js"
URL_LICENSE="https://raw.githubusercontent.com/photonstorm/phaser/v${PHASER_VERSION}/license.txt"

echo
echo "Configuring Target Directories and Files"
echo "----------------------------------------"
TARGET_WWW_DIR="../wwwroot"
TARGET_JS_DIR="${TARGET_WWW_DIR}/js"
TARGET_LICENSE="${TARGET_WWW_DIR}/LICENSE-phaser.txt"
TARGET_PHASER="${TARGET_JS_DIR}/phaser.min.js"

echo
echo "Creating Directories"
echo "--------------------"
mkdir -p "$TARGET_JS_DIR"

echo
echo "Downloading Files"
echo "-----------------"
curl -L -o "$TARGET_PHASER" "$URL_PHASER"
##curl -L -o "$TARGET_LICENSE" "$URL_LICENSE"

echo
echo "==================================="
echo "Finished downloading Phaser files"
echo
