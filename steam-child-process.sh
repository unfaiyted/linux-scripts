#!/bin/bash

# Set the log file location
log_file="steam_game_check.log"

# Function to log messages
log() {
  local message="$1"
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" | tee -a "$log_file"
}

# Get the Steam installation path
steam_path=$(realpath "$(which steam)")
steam_root=$(dirname "$steam_path")

log steam_path: $steam_path
log root: $steam_root

# Set the location of Steam's console.log file
steam_log_file="$steam_root/console.log"

if [[ ! -f $steam_log_file ]]; then
  steam_log_file="$HOME/.steam/logs/console.log"
fi

if [[ -f $steam_log_file ]]; then
  log "Steam log file found: $steam_log_file"

  # Get the last launched game's AppID from the log file
  last_launched_game=$(grep -oP "GameAction.*AppID\s+\K[0-9]+" "$steam_log_file" | tail -n1)

  if [[ $last_launched_game ]]; then
    log "Last launched game's AppID: $last_launched_game"

    # Check if the game is still running
    game_process_info=$(pgrep -a -f "steam_appid=$last_launched_game")

    if [[ $game_process_info ]]; then
      game_pid=$(echo "$game_process_info" | awk '{print $1}')
      game_executable=$(echo "$game_process_info" | awk '{print $NF}')

      log "Running game: $game_executable (Process ID: $game_pid, App ID: $last_launched_game)"
    else
      log "No game is currently running."
    fi
  else
    log "No game has been launched."
  fi
else
  log "Steam log file not found. Make sure Steam is running with -console -condebug options."
fi
