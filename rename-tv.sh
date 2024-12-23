#!/bin/bash

# navigate to the directory containing the movie/tv show folders
cd /media/faiyt/f/downloads/TV/

# loop through each item (directory or file) in the current directory
for item in *; do

    # check if the item is a directory
    if [[ -d "$item" ]]; then
        # check if the directory name contains "_FAILED_"
        if [[ "$item" == *_FAILED_* ]]; then
            echo "[-] : $item"
            # rm -rf "$item"
            continue
        fi

        # get the new directory name
      new_directory_name=$(echo "$item" | sed -E 's/([[:digit:]]{4})[[:alnum:]]*\./(\1)./; s/([[:digit:]]{4}).*/(\1)/; s/[._-]/ /g; s/ UNPACK //g; s/^\s*//; s/\s*$//; s/\s+/ /g; s/\(\(/\(/g; s/\)\)/\)/g')




      # get series name
      series_name=$(echo "$item" | sed 's/\([[:alpha:]].*\)[. ]\([sS][0-9]*[exEX][0-9]*\|[0-9]*[xX][0-9]*\)[. ]*.*/\1/' | sed 's/\./ /g')

      # get season and episode
      season_episode=$(echo "$item" | sed 's/\([[:alpha:]].*\)[. ]\([sS][0-9]*[exEX][0-9]*\|[0-9]*[xX][0-9]*\)[. ]*.*/\2/' | tr '[:upper:]' '[:lower:]')
      if [[ "$season_episode" =~ ^[sS]?([0-9]+)[exEX]([0-9]+)$ ]]; then
          season="${BASH_REMATCH[1]}"
          episode="${BASH_REMATCH[2]}"
      elif [[ "$season_episode" =~ ^([0-9]+)[xX]([0-9]+)$ ]]; then
          season="${BASH_REMATCH[1]}"
          episode="${BASH_REMATCH[2]}"
      fi

      # check if season and episode are valid numbers
      if ! [[ "$season" =~ ^[0-9]+$ ]]; then
            echo "Invalid season number: $season"
            echo "Series name: $series_name"
            echo "Season: $season"
            echo "Episode: $episode"
          continue
      fi

      if ! [[ "$episode" =~ ^[0-9]+$ ]]; then
          echo "Invalid episode number: $episode"
          continue
      fi



      # rename the directory to match the new name
        folder_name=$(basename "$new_directory_name")

        for file in "$item"*; do
#          echo "--- [C]  $file"
              if [[ -f "$file" ]]; then
                  # get the extension from the filename
                 filename=$(basename "$file")

                  extension="${filename##*.}"
                  new_filename=${item}/${series_name} S${season}E${episode}.${extension}

                  echo "--- [M]: $file -> $new_filename"
                  #mv "$file" "${item}/${new_filename}"
              fi
        done

        echo "[R-D]: $item -> $series_name"
        # mv "$item" "$new_directory_name"

    # check if the item is a file
    elif [[ -f "$item" ]]; then
        # get the directory and file name of the item
        directory=$(dirname "$item")
        filename=$(basename "$item")

        # get the new file name (preserve extension)
        new_filename=$(echo "$filename" | sed -E 's/([[:digit:]]{4})[[:alnum:]]*\./(\1)./; s/([[:digit:]]{4}).*/(\1)/; s/[._-]/ /g; s/ UNPACK //g; s/^\s*//; s/\s*$//; s/\s+/ /g; s/\(\(/\(/g; s/\)\)/\)/g')

        # check if the new file name contains a 4-digit year between 1920 and 2024
        if [[ ! "$new_filename" =~ .*[(][[:digit:]]{4}[)].* || $(echo "$new_filename" | grep -oE "[[:digit:]]{4}") -lt 1920 || $(echo "$new_filename" | grep -oE "[[:digit:]]{4}") -gt 2024 ]]; then
            echo "[X]: $filename"
            continue
        fi

        # rename the file to match the new name (preserve extension)
        extension="${filename##*.}"
        new_filename="$new_filename"
        echo "[R]: $filename -> $new_filename"
        mkdir "$new_filename"
        # mv "$directory/$filename" "$directory/$new_filename/$new_filename.$extension"

    else
        echo "Skipping $item (not a directory or file)"
    fi

done
