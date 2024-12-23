#!/bin/bash

# Set the directory to search in
SEARCH_DIR="/media/faiyt/f/movies/"

# Set the new extension to use
NEW_EXT=".avi"

# Set the maximum file size in megabytes to delete
MAX_SIZE=50

# Set dry run flag to true or false
DRY_RUN=true

# Set the log file
LOG_FILE="./mx-file-cleanup.log"

# If dry run is enabled, set the log prefix accordingly
if [ "$DRY_RUN" = true ]; then
  LOG_PREFIX="[DRY RUN] "
else
  LOG_PREFIX=""
fi

# Search for .mx and .MX files in the directory
FILES=$(find "$SEARCH_DIR" -type f \( -name "*.mx" -o -name "*.MX" \))

# Loop through each file found
for FILE in $FILES; do
  # Get the file size in megabytes
  FILE_SIZE=$(du -m "$FILE" | awk '{print $1}')

  # If the file is smaller than the maximum size, delete it
  if [ "$FILE_SIZE" -lt "$MAX_SIZE" ]; then
    echo "$LOG_PREFIX Deleting file: $FILE (size: $FILE_SIZE MB)" >> "$LOG_FILE"
    if [ "$DRY_RUN" = false ]; then
      rm "$FILE"
    fi
  else
    # Otherwise, change the file extension to .avi
    NEW_FILE="${FILE%.*}$NEW_EXT"
    echo "$LOG_PREFIX Renaming file: $FILE -> $NEW_FILE" >> "$LOG_FILE"
    if [ "$DRY_RUN" = false ]; then
      mv "$FILE" "$NEW_FILE"
    fi
  fi
done
