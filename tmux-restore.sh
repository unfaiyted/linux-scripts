#!/bin/bash

# Function to find the tmux resurrect directory
find_resurrect_dir() {
  local xdg_data_home="${XDG_DATA_HOME:-$HOME/.local/share}"
  local possible_dirs=(
    "$HOME/.tmux/resurrect"
    "$xdg_data_home/tmux/resurrect"
  )

  for dir in "${possible_dirs[@]}"; do
    if [ -d "$dir" ]; then
      echo "$dir"
      return 0
    fi
  done

  echo "Error: Could not find tmux resurrect directory" >&2
  exit 1
}

# Function to list save files with readable timestamps
list_save_files() {
  local dir="$1"
  local files=()
  local i=1
  local max_items=30

  # Get all save files and sort them by modification time (newest first)
  while IFS= read -r file; do
    # Skip if file is a symlink
    if [ -L "$file" ]; then
      continue
    fi

    # Get the timestamp from filename (format: tmux_resurrect_YYYYMMDDTHHMMSS.txt)
    local timestamp=$(basename "$file" | grep -o '[0-9]\{8\}T[0-9]\{6\}')

    # Convert timestamp to readable format
    if [[ $timestamp =~ ^([0-9]{4})([0-9]{2})([0-9]{2})T([0-9]{2})([0-9]{2})([0-9]{2})$ ]]; then
      local readable_date="${BASH_REMATCH[1]}-${BASH_REMATCH[2]}-${BASH_REMATCH[3]} ${BASH_REMATCH[4]}:${BASH_REMATCH[5]}:${BASH_REMATCH[6]}"
    else
      local readable_date="Unknown date"
    fi

    echo "$i) $(basename "$file") ($readable_date)"
    files+=("$file")
    ((i++))
  done < <(find "$dir" -maxdepth 1 -type f -name "tmux_*.txt" -exec ls -t {} + | head -n $max_items)

  # Store files array for later use
  declare -p files >/tmp/tmux_restore_files
}

# Main script
resurrect_dir=$(find_resurrect_dir)
if [ $? -ne 0 ]; then
  exit 1
fi

echo "Found tmux resurrect directory: $resurrect_dir"
echo "Available save files (most recent 30):"
echo "-------------------"

# List all save files
list_save_files "$resurrect_dir"

# Source the files array
. /tmp/tmux_restore_files
rm /tmp/tmux_restore_files

# If no files found
if [ ${#files[@]} -eq 0 ]; then
  echo "No save files found in $resurrect_dir"
  exit 1
fi

# Prompt for selection
echo
read -p "Enter the number of the save file you want to restore (1-${#files[@]}): " selection

# Validate input
if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -lt 1 ] || [ "$selection" -gt ${#files[@]} ]; then
  echo "Invalid selection. Please enter a number between 1 and ${#files[@]}"
  exit 1
fi

# Get the selected file
selected_file="${files[$((selection - 1))]}"

# Create/update the symlink
ln -sf "$selected_file" "$resurrect_dir/last"

echo "Successfully linked $(basename "$selected_file") as 'last'"
echo "You can now restore this save using tmux prefix + Ctrl-r"
