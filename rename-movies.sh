#!/bin/bash

# navigate to the directory containing the movie/tv show folders
cd /media/faiyt/g/movies/

# loop through each item (directory or file) in the current directory
for item in *; do

  # check if the item is a directory
  if [[ -d "$item" ]]; then
    # check if the directory name contains "_FAILED_"
    if [[ "$item" == *_FAILED_* ]]; then
      #echo "[-] : $item"
      rm -rf "$item"
      continue
    fi

    # get the new directory name
    new_directory_name=$(echo "$item" | sed -E 's/([[:digit:]]{4})[[:alnum:]]*\./(\1)./; s/([[:digit:]]{4}).*/(\1)/; s/[._-]/ /g; s/ UNPACK //g; s/^\s*//; s/\s*$//; s/\s+/ /g; s/\(\(/\(/g; s/\)\)/\)/g')
    # check if the new directory name contains a 4-digit year between 1920 and 2024
    if [[ ! "$new_directory_name" =~ .*[(][[:digit:]]{4}[)].* || $(echo "$new_directory_name" | grep -oE "[[:digit:]]{4}") -lt 1920 || $(echo "$new_directory_name" | grep -oE "[[:digit:]]{4}") -gt 2024 ]]; then
      echo "[UNKNOWN]: $item"
      continue
    fi

    # rename the directory to match the new name
    folder_name=$(basename "$new_directory_name")

    echo "[DIR-R]: $item -> $new_directory_name"

    cd "$item"

    for file in "$item"*; do
      echo "--- [CHILD]  $file"
      if [[ -f "$file" ]]; then
        # get the extension from the filename
        filename=$(basename "$file")
        extension="${filename##*.}"

        # if mx or MX extension change it to avi
        if [[ "$extension" == "mx" || "$extension" == "MX" ]]; then
          extension="avi"
        fi

        echo "--- ORIGINAL: $filename"
        new_filename=${folder_name}.${extension}

        echo "--- [DIR-CHILD-R]: $file -> $new_filename"
        mv "./$file" "./${new_filename}"
      fi
    done
    cd ..

    mv "./$item" "./$new_directory_name"

  # check if the item is a file
  elif [[ -f "$item" ]]; then
    # get the directory and file name of the item
    directory=$(dirname "$item")
    filename=$(basename "$item")

    # get the new file name (preserve extension)
    new_filename=$(echo "$filename" | sed -E 's/([[:digit:]]{4})[[:alnum:]]*\./(\1)./; s/([[:digit:]]{4}).*/(\1)/; s/[._-]/ /g; s/ UNPACK //g; s/^\s*//; s/\s*$//; s/\s+/ /g; s/\(\(/\(/g; s/\)\)/\)/g')

    # check if the new file name contains a 4-digit year between 1920 and 2024
    if [[ ! "$new_filename" =~ .*[(][[:digit:]]{4}[)].* || $(echo "$new_filename" | grep -oE "[[:digit:]]{4}") -lt 1920 || $(echo "$new_filename" | grep -oE "[[:digit:]]{4}") -gt 2024 ]]; then
      echo "[UNKNOWN-FILE]: $filename"
      continue
    fi

    # rename the file to match the new name (preserve extension)
    extension="${filename##*.}"

    echo "extension: $extension"

    # if mx or MX extension change it to avi
    if [[ "$extension" == "mx" || "$extension" == "MX" ]]; then
      extension="avi"
    fi

    new_filename="$new_filename"
    echo "[R]: $filename -> $new_filename"
    mkdir "$new_filename"
    echo "[M] mv \"$directory/$filename\" \"$directory/$new_filename/$new_filename.$extension\""
    mv "$directory/$filename" "$directory/$new_filename/$new_filename.$extension"

  else
    echo "Skipping $item (not a directory or file)"
  fi

done
