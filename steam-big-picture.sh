#!/bin/bash

# Check if Steam is running
steam_pid=$(pgrep -x steam)

# If Steam is running
if [[ $steam_pid ]]; then
  # Send SIGUSR1 to force Steam into Big Picture Mode
  kill -10 $steam_pid &

steam -bigpicture -console -condebug
  # Get Steam's window ID
  steam_window_id=$(wmctrl -lx | grep -i 'steam.Steam' | awk '{print $1}')

  # Give focus to Steam's window
  if [[ $steam_window_id ]]; then
    wmctrl -i -a $steam_window_id
  fi
else
  # Launch Steam in Big Picture Mode
  steam -bigpicture -console -condebug &
fi

