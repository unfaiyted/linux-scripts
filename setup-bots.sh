#! /bin/sh
pkill miqoradar.exe
pkill miqobot_v1.3.48

WINEPREFIX="/home/faiyt/.xlcore/wineprefix/" WINEESYNC=1 DOTNET_ROOT="C:\\Program Files\\dotnet" \
DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false WINEDLLOVERRIDES="msquic=,mscoree=n,b" DOTNET_BUNDLE_EXTRACT_BASE_DIR= /home/faiyt/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.10.r3.g560db77d/bin/wine64 ~/Downloads/miqobot_v1.3.48.exe &

echo Starting MiquoBot;

