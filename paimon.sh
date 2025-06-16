#!/bin/sh

source ./paimon.conf

echo "Step 1. Open your gacha log in the game"
read -p "Press enter if you have..."

# Check webview version
VERSION=$(ls -1 "${GAME_PATH}/GenshinImpact_Data/webCaches" | grep "2." | tail -1)

# Data file path
DATA_PATH="${GAME_PATH}/GenshinImpact_Data/webCaches/${VERSION}/Cache/Cache_Data/data_2"

# Get base url
BASE_URL=$(strings "$DATA_PATH" | grep "https://gs.hoyoverse.com"| tail -1 | cut -d "/" -f3-)

# Append log to the base url
LOG_URL="${BASE_URL}/#/log"

echo "Step 2. Copy the url below"

# Print gacha log url
echo $LOG_URL
