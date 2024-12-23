#!/bin/bash

# Check if wmctrl is installed
if ! command -v wmctrl &>/dev/null; then
	echo "wmctrl could not be found, please install it."
	exit 1
fi

# Previous window list
prev_windows=$(wmctrl -l)

while true; do
	# Current window list
	current_windows=$(wmctrl -l)

	# Compare with previous list and print new windows
	diff <(echo "$prev_windows") <(echo "$current_windows") | grep ">" | cut -c 3-

	# Update previous window list
	prev_windows=$current_windows

	# Sleep for a short period to avoid excessive CPU usage
	sleep 1
done
