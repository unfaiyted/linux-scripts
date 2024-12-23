#!/bin/bash

SOURCE="/media/faiyt/f/config/plex"

DESTINATIONS=(
	"/home/faiyt/scripts/plex"
)

	# "/media/faiyt/f/config/plex-backup"
# Define the log file name with current date and time
LOGFILE="/home/faiyt/scripts/logs/plex_rsync_$(date +%Y%m%d_%H%M%S).log"

# Define a function to start the containers
start_containers() {
	docker start plex >>"$LOGFILE" 2>&1
	docker start plex-backup >>"$LOGFILE" 2>&1
}

# Set up a trap to start the containers when the script exits
trap start_containers EXIT

# Get the current hour in 24-hour format
current_hour=$(date +%H)

# If it's after 10 PM
if ((current_hour >= 22)); then
	# Stop the containers
	docker stop plex >>"$LOGFILE" 2>&1
	docker stop plex-backup >>"$LOGFILE" 2>&1
fi

for DEST in "${DESTINATIONS[@]}"; do
	rsync -av --delete "$SOURCE" "$DEST" >>"$LOGFILE" 2>&1
done
