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

SELECTION=$(echo -e "screenshot selection\nscreenshot eDP-1\nscreenshot HDMI-A-1\nscreenshot both screens\nrecord selection\nrecord eDP-1\nrecord HDMI-A-1" | fuzzel -d -p "󰄀 " -w 25 -l 6)

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
*) ;;
esac
