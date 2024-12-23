#!/bin/bash

half='2560x1440'
quarter='1760x1440'
threeQuarters='3360x1440'
fullReduced='3840x1080'
full='7680x2160'

# Gets the current max res from the DP-2 input
maxResolution=$(xrandr | grep -e "+" | grep -e "DP-4" -A 1 | grep -E "[0-9]{4}x[0-9]{4} " -o)

echo "$maxResolution"

dp2=$(xrandr | grep -e "DP-4")
echo "$dp2"

pos='0x0'
secondaryPos='0x0'
metaMode=""

if [[ "$maxResolution" == *"$threeQuarters"* ]]; then
	echo "It's threeQuarters"
	pos='3360x1080'
	secondaryPos='2000x0'
	mainSize=$threeQuarters
	secondarySize=$quarter
	metaMode="DP-4: 3360x1440 +0+1080 { ForceFullCompositionPipeline = On }, HDMI-0: 1920x1080 +720+0 { ForceFullCompositionPipeline = On }"
fi

if [[ "$maxResolution" == *"$half"* ]]; then
	echo "It's half"
	pos='2560x1080'
	secondaryPos='1500x0'
	mainSize=$half
	secondarySize=$half
	metaMode="DP-4: 2560x1440 +0+1080 { ForceFullCompositionPipeline = On }, HDMI-0: 1920x1080 +720+0 { ForceFullCompositionPipeline = On }"
fi

if [[ "$maxResolution" == *"$full"* || "$maxResolution" == *"3840x1080"* ]]; then
	echo "It's full"
	pos='1760x1080'
	secondaryPos='3000x0'
	mainSize=$full
	secondarySize='disabled'
	metaMode="DP-4: 5120x1440 +0+1080 { ForceFullCompositionPipeline = On }, HDMI-0: 1920x1080 +720+0 { ForceFullCompositionPipeline = On }"
fi

if [[ "$maxResolution" == *"$quarter"* ]]; then
	echo "It's full"
	pos='1000x-1080'
	mainSize=$quarter
	secondarySize=$threeQuarters
	metaMode="DP-3: 1760x1440 +0+1080 { ForceFullCompositionPipeline = On }, HDMI-0: 1920x1080 +720+0 { ForceFullCompositionPipeline = On }"
fi

echo "mainSize:  $mainSize"

# Apply scaling
gsettings set org.gnome.desktop.interface scaling-factor 1

# Apply monitor settings with xrandr
# xrandr --output DP-2 --primary --mode $mainSize --scale 1x1 --pos 0x0
# xrandr --output HDMI-0 --mode 1920x1080 --scale 1x1 --pos $pos

# Configure secondary monitor if enabled
if [[ "$secondarySize" != "disabled" ]]; then
	xrandr --output DP-4 --mode $secondarySize --scale 1x1 --pos $secondaryPos
fi

# Set wallpapers
feh --bg-fill ~/Pictures/Wallpaper/main.png
feh --bg-fill ~/Pictures/Wallpaper/main.png

# Restart xborders
killall -9 xborders
/home/faiyt/codebase/xborder/xborders --config /home/faiyt/codebase/xborder/example_config.json

# Apply NVIDIA settings
nvidia-settings --assign CurrentMetaMode="$metaMode"
xrandr --output DP-2 --primary

# nvidia-settings: X configuration file generated by nvidia-setting
# nvidia-settings:  version 545.29.02

# Section "ServerLayout"
#     Identifier     "Layout0"
#     Screen      0  "Screen0" 0 0
#     InputDevice    "Keyboard0" "CoreKeyboard"
#     InputDevice    "Mouse0" "CorePointer"
#     Option         "Xinerama" "0"
# EndSection
#
# Section "Files"
# EndSection
#
# Section "Module"
#     Load           "dbe"
#     Load           "extmod"
#     Load           "type1"
#     Load           "freetype"
#     Load           "glx"
# EndSection
#
# Section "InputDevice"
#     # generated from default
#     Identifier     "Mouse0"
#     Driver         "mouse"
#     Option         "Protocol" "auto"
#     Option         "Device" "/dev/psaux"
#     Option         "Emulate3Buttons" "no"
#     Option         "ZAxisMapping" "4 5"
# EndSection
#
# Section "InputDevice"
#     # generated from default
#     Identifier     "Keyboard0"
#     Driver         "kbd"
# EndSection
#
# Section "Monitor"
#     # HorizSync source: edid, VertRefresh source: edid
#     Identifier     "Monitor0"
#     VendorName     "Unknown"
#     ModelName      "Samsung LC49G95T"
#     HorizSync       30.0 - 183.0
#     VertRefresh     50.0 - 120.0
#     Option         "DPMS"
# EndSection
#
# Section "Device"
#     Identifier     "Device0"
#     Driver         "nvidia"
#     VendorName     "NVIDIA Corporation"
#     BoardName      "NVIDIA GeForce RTX 4090"
# EndSection
#
# Section "Screen"
#     Identifier     "Screen0"
#     Device         "Device0"
#     Monitor        "Monitor0"
#     DefaultDepth    24
#     Option         "Stereo" "0"
#     Option         "nvidiaXineramaInfoOrder" "DFP-3"
#     Option         "metamodes" "DP-2: nvidia-auto-select +0+1080 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, HDMI-0: 1920x1080 +720+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
#     Option         "SLI" "Off"
#     Option         "MultiGPU" "Off"
#     Option         "BaseMosaic" "off"
#     SubSection     "Display"
#         Depth       24
#     EndSubSection
# EndSection
#
