#!/usr/bin/env bash
set -euo pipefail

# Keep this version aligned with the bundled upstream assets (not wrapper-only patches).
PHASER_VERSION="3.90.0"
PHASER_BASE_URL="https://cdn.jsdelivr.net/npm/phaser@${PHASER_VERSION}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TARGET_WWW_DIR="${SCRIPT_DIR}/../wwwroot"
DOWNLOAD_DIR="$(mktemp -d)"
trap 'rm -rf -- "$DOWNLOAD_DIR"' EXIT

printf 'Downloading Phaser %s assets and license...\n' "$PHASER_VERSION"
curl --fail --show-error --location \
  "${PHASER_BASE_URL}/dist/phaser.min.js" \
  --output "${DOWNLOAD_DIR}/phaser.min.js"
curl --fail --show-error --location \
  "${PHASER_BASE_URL}/LICENSE.md" \
  --output "${DOWNLOAD_DIR}/LICENSE-phaser.txt"

# Update the package only after both downloads have succeeded.
mkdir -p "${TARGET_WWW_DIR}/js"
mv -- "${DOWNLOAD_DIR}/phaser.min.js" "${TARGET_WWW_DIR}/js/phaser.min.js"
mv -- "${DOWNLOAD_DIR}/LICENSE-phaser.txt" "${TARGET_WWW_DIR}/LICENSE-phaser.txt"
printf 'Downloaded Phaser %s to %s\n' "$PHASER_VERSION" "$TARGET_WWW_DIR"
