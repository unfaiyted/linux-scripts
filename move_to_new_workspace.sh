#!/bin/bash

echo "Starting script..."

last_window_name=""
last_window_id=""

handle_window_focus() {
	local container_json=$1
	echo "Function called with container JSON: $container_json"

	# Extract the window name from the JSON
	local window_name=$(echo "$container_json" | jq -r '.name')
	echo "Window name: $window_name"
	echo "Last window name: $last_window_name"

	# echo "Not switching modes."
	# i3-msg mode 'default'

	last_window_name="$window_name"
	last_window_id=$(echo "$container_json" | jq -r '.id')
	echo "Last window id: $last_window_id"
}

i3-msg -t subscribe -m '[ "window" ]' | jq --unbuffered -c '.container' | while read -r container_json; do
	handle_window_focus "$container_json"
done

# # Retrieve the focused window
# CURRENT_WINDOW=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name')
#
# # Create a new workspace and move to it
# NEW_WORKSPACE=$(($(i3-msg -t get_workspaces | jq -r '.[-1].num') + 1))
# i3-msg workspace $NEW_WORKSPACE
#
# # Move the previously focused window to the new workspace
# i3-msg "[class=\"$CURRENT_WINDOW\"] move to workspace $NEW_WORKSPACE"
#
