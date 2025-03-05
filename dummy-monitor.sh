# Create virtual display
# hyprctl output create auto VIRTUAL-1
# Or more specifically:
xrandr --addmode VIRTUAL-1 1920x1080
xrandr --output VIRTUAL-1 --mode 1920x1080 --above eDP-1 # (replace eDP-1 with your actual display name)
