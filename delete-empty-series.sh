#!/bin/bash

# Set the threshold for the minimum total file size in MB
threshold=50

cd /media/faiyt/f/downloads/TV/

# Loop through all folders in the current directory
for folder in */; do
  # Calculate the total file size in MB using the du command
  size=$(du -sm "$folder" | awk '{print $1}')
  # Compare the total file size to the threshold
  if (( $size < $threshold )); then
    # Delete the folder and all its contents using the rm command
    rm -r "$folder"
    echo "Deleted folder $folder"
  fi
done
