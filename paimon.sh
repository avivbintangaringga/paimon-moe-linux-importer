#!/bin/sh

CONFIG_FILE=./config.paimon

[ ! -f $CONFIG_FILE ] && touch $CONFIG_FILE

FORCE_SET_GAME_PATH=false

# Set config NAME VALUE
set_config() {
  if grep -q "^${1}=" $CONFIG_FILE
  then 
    sed -i "s/^${1}=.*/${1}=\"${2//\//\\/}\"/" $CONFIG_FILE
  else
    echo "${1}=\"${2}\"" >> $CONFIG_FILE
  fi

  # Reimport config file
  . $CONFIG_FILE
}

input_game_path() {
  read -p "Enter absolute game path: " GAME_PATH

  # Change game path config
  set_config "GAME_PATH" "${GAME_PATH}"

  FORCE_SET_GAME_PATH=false
}

# Show help
show_help() {
  echo "Usage:"
  echo "  $(basename $0) [options]"
  echo ""
  echo "Options:"
  echo "  -h        Show help"
  echo "  -c        Change game path"
}

# Check options
while getopts "hc" arg
do
  case $arg in
    c)
      FORCE_SET_GAME_PATH=true
      ;;
    h | *)
      show_help
      exit 0
      ;;
  esac
done

# Import config file
. $CONFIG_FILE

echo "##############################"
echo "# Paimon.moe Importer Script #"
echo "##############################"


# Check if game path is set
([ -z "$GAME_PATH" ] || $FORCE_SET_GAME_PATH) && echo && input_game_path

# Check if game path is valid
while [ ! -d "$GAME_PATH/GenshinImpact_Data" ]
do
  echo "ERROR: specified game path is not valid!"
  echo ""
  input_game_path
done

echo ""
echo "Step 1. Open your gacha log in the game. Make sure it is updated."
read -p "Press enter if you have..."

# Check webview version
VERSION=$(ls -1 "${GAME_PATH}/GenshinImpact_Data/webCaches" | grep "2." | tail -1)

# Data file path
DATA_PATH="${GAME_PATH}/GenshinImpact_Data/webCaches/${VERSION}/Cache/Cache_Data/data_2"

# Get base url
BASE_URL=$(strings "$DATA_PATH" | grep "https://gs.hoyoverse.com"| tail -1 | cut -d "/" -f3-)

# Append log to the base url
LOG_URL="${BASE_URL}/#/log"

echo ""
echo "Step 2. Copy the url below"

# Print gacha log url
echo ""
echo $LOG_URL

echo ""
echo "Step 3. Paste into paimon.moe import section"
