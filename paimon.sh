#!/bin/sh

source ./paimon.conf

VERSION="2.37.0.0"
DATA_PATH="${GAME_PATH}/GenshinImpact_Data/webCaches/${VERSION}/Cache/Cache_Data/data_2"
BASE_URL=$(strings "$DATA_PATH" | grep "https://gs.hoyoverse.com"| tail -n1 | cut -d "/" -f3-)
LOG_URL="${BASE_URL}/#/log"

echo $LOG_URL
