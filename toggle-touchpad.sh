#!/bin/bash
STATE_FILE="/tmp/touchpad_state"

# Initialize state file if it doesn't exist
if [ ! -f "$STATE_FILE" ]; then
  echo "enabled" >"$STATE_FILE"
fi

current_state=$(cat "$STATE_FILE")

if [ "$current_state" = "enabled" ]; then
  hyprctl keyword "device[apple-mtp-multi-touch]:enabled" false
  echo "disabled" >"$STATE_FILE"
  notify-send "Touchpad disabled"
else
  hyprctl keyword "device[apple-mtp-multi-touch]:enabled" true
  echo "enabled" >"$STATE_FILE"
  notify-send "Touchpad enabled"
fi
