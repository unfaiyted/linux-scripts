#!/bin/env bash

wf-recorder_check() {
  if pgrep -x "wf-recorder" >/dev/null; then
    pkill -INT -x wf-recorder
    notify-send "Stopping all instances of wf-recorder" "$(cat /tmp/recording.txt)"
    wl-copy <"$(cat /tmp/recording.txt)"
    exit 0
  fi
}

wf-recorder_check

SELECTION=$(echo -e "screenshot selection\nscreenshot eDP-1\nscreenshot HDMI-A-1\nscreenshot both screens\nrecord selection\nrecord eDP-1\nrecord HDMI-A-1\nconvert to webm\nconvert for iPhone" | fuzzel -d -p "󰄀 " -w 25 -l 8)

IMG="${HOME}/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%m-%s).png"
VID="${HOME}/Videos/Recordings/$(date +%Y-%m-%d_%H-%m-%s).mp4"

case "$SELECTION" in
"screenshot selection")
  grim -g "$(slurp)" "$IMG"
  wl-copy <"$IMG"
  notify-send "Screenshot Taken" "${IMG}"
  ;;
"screenshot eDP-1")
  grim -c -o eDP-1 "$IMG"
  wl-copy <"$IMG"
  notify-send "Screenshot Taken" "${IMG}"
  ;;
"screenshot HDMI-A-1")
  grim -c -o HDMI-A-1 "$IMG"
  wl-copy <"$IMG"
  notify-send "Screenshot Taken" "${IMG}"
  ;;
"screenshot both screens")
  grim -c -o eDP-1 "${IMG//.png/-eDP-1.png}"
  grim -c -o HDMI-A-1 "${IMG//.png/-HDMI-A-1.png}"
  montage "${IMG//.png/-eDP-1.png}" "${IMG//.png/-HDMI-A-1.png}" -tile 2x1 -geometry +0+0 "$IMG"
  wl-copy <"$IMG"
  rm "${IMG//.png/-eDP-1.png}" "${IMG/.png/-HDMI-A-1.png}"
  notify-send "Screenshot Taken" "${IMG}"
  ;;
"record selection")
  # echo "$VID" >/tmp/recording.txt
  wf-recorder -g "$(slurp)" -f "$VID"
  ;;
"record eDP-1")
  echo "$VID" >/tmp/recording.txt
  wf-recorder -a -o eDP-1 -f "$VID"
  ;;
"record HDMI-A-1")
  # echo "$VID" >/tmp/recording.txt
  wf-recorder -a -o HDMI-A-1 -f "$VID"
  ;;
"record both screens")
  notify-send "recording both screens is not functional"
  ;;
"convert to webm")
  # Check if ffmpeg is installed
  if ! command -v ffmpeg >/dev/null 2>&1; then
    notify-send "Error" "ffmpeg is not installed. Please install it to use this feature."
    exit 1
  fi

  RECORDING_DIR="${HOME}/Videos/Recordings"
  CONVERTED=0
  TOTAL=0
  
  for mp4_file in "${RECORDING_DIR}"/*.mp4; do
    if [ -f "$mp4_file" ]; then
      TOTAL=$((TOTAL+1))
      webm_file="${mp4_file%.mp4}.webm"
      
      # Check if webm version doesn't already exist
      if [ ! -f "$webm_file" ]; then
        # Simpler ffmpeg command with basic settings
        ffmpeg -y -i "$mp4_file" -c:v libvpx -b:v 1M -c:a libvorbis "$webm_file" 2>/tmp/ffmpeg_error.log
        
        if [ $? -eq 0 ]; then
          CONVERTED=$((CONVERTED+1))
          notify-send "Converted to WebM" "$(basename "$mp4_file")"
        else
          error=$(cat /tmp/ffmpeg_error.log | tail -n 5)
          notify-send "Conversion Failed" "Error: $error"
        fi
      fi
    fi
  done
  
  if [ $TOTAL -eq 0 ]; then
    notify-send "WebM Conversion" "No MP4 files found in Recordings folder"
  else
    notify-send "WebM Conversion Complete" "Converted $CONVERTED out of $TOTAL MP4 files"
  fi
  ;;

"convert for iPhone")
  # Check if ffmpeg is installed
  if ! command -v ffmpeg >/dev/null 2>&1; then
    notify-send "Error" "ffmpeg is not installed. Please install it to use this feature."
    exit 1
  fi

  RECORDING_DIR="${HOME}/Videos/Recordings"
  CONVERTED=0
  SKIPPED_IPHONE=0
  SKIPPED_EXISTING=0
  TOTAL_FILES=0
  
  for mp4_file in "${RECORDING_DIR}"/*.mp4; do
    if [ -f "$mp4_file" ]; then
      TOTAL_FILES=$((TOTAL_FILES+1))
      base_filename=$(basename "$mp4_file")
      
      # Skip files with "iphone" in the filename
      if [[ $base_filename == *"iphone"* ]]; then
        SKIPPED_IPHONE=$((SKIPPED_IPHONE+1))
        continue
      fi
      
      iphone_file="${mp4_file%.mp4}-iphone.mp4"
      
      # Check if iPhone version doesn't already exist
      if [ ! -f "$iphone_file" ]; then
        # Simpler ffmpeg command for iPhone compatibility
        ffmpeg -y -i "$mp4_file" -vcodec h264 -acodec aac "$iphone_file" 2>/tmp/ffmpeg_error.log
        
        if [ $? -eq 0 ]; then
          CONVERTED=$((CONVERTED+1))
          notify-send "Converted for iPhone" "$(basename "$mp4_file")"
        else
          error=$(cat /tmp/ffmpeg_error.log | tail -n 5)
          notify-send "Conversion Failed" "Error: $error"
        fi
      else
        SKIPPED_EXISTING=$((SKIPPED_EXISTING+1))
      fi
    fi
  done
  
  if [ $TOTAL_FILES -eq 0 ]; then
    notify-send "iPhone Conversion" "No MP4 files found in Recordings folder"
  else
    notify-send "iPhone Conversion Complete" "Converted: $CONVERTED files
Skipped (already iPhone): $SKIPPED_IPHONE files
Skipped (has iPhone version): $SKIPPED_EXISTING files
Total files checked: $TOTAL_FILES"
  fi
  ;;

*) ;;
esac

