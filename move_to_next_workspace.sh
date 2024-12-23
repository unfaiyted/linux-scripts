#!/bin/bash

# Function to extract the workspace number from its name
extract_number_from_name() {
	echo "$1" | grep -o -E '[0-9]+' | head -1
}

# Get all workspace names
WORKSPACES=$(i3-msg -t get_workspaces | jq -r '.[] | .name')

# Convert workspace names to numbers and find the max and min
WORKSPACE_NUMBERS=$(echo "$WORKSPACES" | while read -r name; do
	extract_number_from_name "$name"
done)

HIGHEST_WS=$(echo "$WORKSPACE_NUMBERS" | sort -n | tail -1)
LOWEST_WS=$(echo "$WORKSPACE_NUMBERS" | sort -n | head -1)

# Current workspace number
CURRENT_WS_NAME=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')
CURRENT_WS=$(extract_number_from_name "$CURRENT_WS_NAME")

# Determine target workspace based on argument
if [ "$1" == "next" ]; then
	TARGET_WS=$((CURRENT_WS + 1))
	if [ "$TARGET_WS" -gt "$HIGHEST_WS" ]; then
		TARGET_WS=$LOWEST_WS
	fi
elif [ "$1" == "prev" ]; then
	TARGET_WS=$((CURRENT_WS - 1))
	if [ "$TARGET_WS" -lt "$LOWEST_WS" ]; then
		TARGET_WS=$HIGHEST_WS
	fi
else
	echo "Invalid argument. Use 'next' or 'prev'."
	exit 1
fi

# Move the container and focus on the target workspace
# Find the name of the target workspace
TARGET_WS_NAME=$(echo "$WORKSPACES" | while read -r name; do
	WS_NUM=$(extract_number_from_name "$name")
	if [ "$WS_NUM" -eq "$TARGET_WS" ]; then
		echo "$name"
		break
	fi
done)

i3-msg "move container to workspace $TARGET_WS_NAME"
i3-msg "workspace $TARGET_WS_NAME"
