#! /bin/sh



#rpcapd -l localhost -n &

##steam-run bash <<-EOF
##XIVLauncher.Core &
#export WINDLLOVERRIDES=
#DOTNET_ROOT="C:\\Program Files\\dotnet" WINEDLLOVERRIDES=msquic=,wpcap=,mscoree=n,b WINEESYNC=1 WINEPREFIX=~/.xlcore/wineprefix/ \
#~/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.10.r3.g560db77d/bin/wine ~/.xlcore/wineprefix/drive_c/iinact.exe &
# IINACT_PID=$!
#
#echo
#echo "Waiting for IINACT to die.."
#wait $IINACT_PID
#
#
#DOTNET_BUNDLE_EXTRACT_BASE_DIR=C:\\IINET\\
#!/usr/bin/env bash

#DOTNET_ROOT="C:\\Program Files\\dotnet" DOTNET_BUNDLE_EXTRACT_BASE_DIR=C:\\IINET\\ WINEPREFIX=/home/faiyt/.xlcore/wineprefix WINEESYNC=1 WINEDLLOVERRIDES=msquic=,wpcap=n,mscoree=n,b ~/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.15.r4.gfa8d0abc/bin/wine ~/.xlcore/wineprefix/drive_c/IINACT/IINACT.exe

#steam bash <<-EOF
#steam steam://rungameid/14480958752234143744

#DOTNET_ROOT="C:\\Program Files\\dotnet" DOTNET_BUNDLE_EXTRACT_BASE_DIR=C:\\IINET\\ WINEDLLOVERRIDES=msquic=,wpcap=,mscoree=n,b WINEESYNC=1 WINEPREFIX=~/.xlcore/wineprefix/ ~/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.15.r4.gfa8d0abc/bin/wine ~/.xlcore/wineprefix/drive_c/IINACT/IINACT.exe

#IINACT_PID=$!
#
#echo
#echo "Waiting for IINACT to die.."

#EOF

#echo
#echo "Killing rpcapd"
#pkill -9 rpcapd

##WINEESYNC=1 WINEPREFIX=~/.xlcore/wineprefix/ steam-run ~/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.10.r3.g560db77d/bin/wine ~/.xlcore/wineprefix/drive_c/IINACT.exe
#./wine /home/saheki/xivlauncher/wineprefix/drive_c/dotnet-sdk-7.0.201-win-x64.exe

#WINEPREFIX=~/.xlcore/wineprefix/ wine ~/.xlcore/wineprefix/drive_c/iinact.exe

#echo
#echo "Killing rpcapd"
#pkill -9 rpcapd



#DOTNET_ROOT="C:\\Program Files\\dotnet" DOTNET_BUNDLE_EXTRACT_BASE_DIR= WINEPREFIX=~/.xlcore/wineprefix WINEESYNC=1 ~/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.10.r3.g560db77d/bin/wine ~/.xlcore/wineprefix/drive_c/WinPcap_4_1_3.exe

#env DOTNET_ROOT="$HOME/.xlcore/runtime/" \
#    DOTNET_BUNDLE_EXTRACT_BASE_DIR= WINEPREFIX="$(realpath ~/.xlcore/wineprefix)" \
#    WINEDEBUG="-all" \
#    WINEDLLOVERRIDES="msquic=\,mscoree=n\,b\;wpcap=n" \
#    WINEFSYNC="1" ~/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.10.r3.g560db77d/bin/wine64 "$HOME/.xlcore/compatibilitytool/beta/*/bin/wine64"

#DOTNET_ROOT="C:\\Program Files\\dotnet" DOTNET_BUNDLE_EXTRACT_BASE_DIR= WINEPREFIX=~/.xlcore/wineprefix WINEESYNC=1 ~/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.15.r4./bin/wine ~/.xlcore/wineprefix/drive_c/WinPcap_4_1_3.exe
#
#
#export FFXIV_WINEPREFIX= ~/.xlcore/wineprefix
#export FFXIV_WINE= "$HOME/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.15.r4.gfa8d0abc/bin/wine"
#export FFXIV_DOTNET_ROOT= "C:\\Program Files\\dotnet"
#
## 1. Download Wpcap
## 2. Download Compatability tool
#
## WINEDLLOVERRIDES=msquic=,wpcap=n,mscoree=n,b
#
#DOTNET_ROOT="C:\\Program Files\\dotnet" DOTNET_BUNDLE_EXTRACT_BASE_DIR= WINEPREFIX=~/.xlcore/wineprefix WINEESYNC=1 ~/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.10.r3.g560db77d/bin/wine ~/.xlcore/wineprefix/drive_c/WinPcap_4_1_3.exe
#
#
#DOTNET_ROOT="C:\\Program Files\\dotnet" DOTNET_BUNDLE_EXTRACT_BASE_DIR= WINEPREFIX=~/.xlcore/wineprefix WINEESYNC=1 ~/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.10.r3.g560db77d/bin/wine ~/.xlcore/wineprefix/drive_c/windowsdesktop-runtime-7.0.2-win-x64.exe
#
#

#To solve problem #3, first we will grant network capture capabilities to the four programs:
#sudo setcap cap_net_admin,cap_net_raw,cap_sys_ptrace=eip ~/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.15.r4.gfa8d0abc/bin/wine
#sudo setcap cap_net_admin,cap_net_raw,cap_sys_ptrace=eip ~/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.15.r4.gfa8d0abc/bin/wine64
#sudo setcap cap_net_admin,cap_net_raw,cap_sys_ptrace=eip ~/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.15.r4.gfa8d0abc/bin/wineserver
#sudo setcap cap_net_admin,cap_net_raw,cap_sys_ptrace=eip ~/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.15.r4.gfa8d0abc/bin/wine64-preloader

#!/bin/sh

echo Killing processes
pkill ffxiv_dx11.exe
pkill ffxiv_dx9.exe
pkill taskmgr
pkill Dalamud
pkill XIVLauncher
pkill IINACT
pkill miqoradar.exe
pkill miqobot_v1.3.48

#echo Looking for Steam
#if [[ "$(pgrep steam)" == "" ]]; then
#    echo Starting steam
#    rm Steam_log.txt
#    exec steam -silent > Steam_log.txt 2>&1 &
#    echo Waiting Steam
#    for (( i = 0; ; ++i )); do
#        if [[ $i == 5400 ]]; then # 3 minutes
#            echo Aborting! Steam took to long
#            exit
#        fi
#        if  [[ "$(cat Steam_log.txt | grep "System startup time:")" != "" ]]; then
#            break
#        fi
#        sleep 0.033s
#    done
#fi
#echo Steam is ready


# Dependencies for new installs




#export FFXIV_WINE_BIN=/home/faiyt/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.15.r4.gfa8d0abc/bin
#export

#cd /home/faiyt/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.15.r4.gfa8d0abc/bin

#cd /home/faiyt/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.10.r3.g560db77d/bin



wmctrl -s 2

#echo Starting INNACT
#WINEPREFIX="/home/faiyt/.xlcore/wineprefix/" WINEESYNC=1 DOTNET_ROOT="C:\\Program Files\\dotnet" \
#DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false WINEDLLOVERRIDES="msquic=,mscoree=n,b" DOTNET_BUNDLE_EXTRACT_BASE_DIR=C:\\IINET\\ /home/faiyt/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.10.r3.g560db77d/bin/wine64 /home/faiyt/.xlcore/wineprefix/drive_c/IINACT/IINACT.exe &
#
# task man
#WINEPREFIX="/home/faiyt/.xlcore/wineprefix/" WINEESYNC=1 DOTNET_ROOT="C:\\Program Files\\dotnet" \
#DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false WINEDLLOVERRIDES="msquic=,mscoree=n,b" DOTNET_BUNDLE_EXTRACT_BASE_DIR= /home/faiyt/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.10.r3.g560db77d/bin/wine64 taskmgr &

# miqo
#WINEPREFIX="/home/faiyt/.xlcore/wineprefix/" WINEESYNC=1 DOTNET_ROOT="C:\\Program Files\\dotnet" \
#DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false WINEDLLOVERRIDES="msquic=,mscoree=n,b" DOTNET_BUNDLE_EXTRACT_BASE_DIR= /home/faiyt/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.10.r3.g560db77d/bin/wine64 ~/Downloads/miqobot_v1.3.48.exe &

echo Starting XIVLauncher
#exec env OBS_VKCAPTURE=1 XIVLauncher.Core > XIVLauncher_log.txt 2>&1 &

XIVLauncher.Core &

# switching current workspace
wmctrl -s 2 &

echo Starting cactbot ui
cd ~/codebase/cactbot/
npm start &
echo "Done!"

# WINEPREFIX="/home/faiyt/.xlcore/wineprefix/" WINEESYNC=1 WINEFSYNC=1 DOTNET_ROOT="C:\\Program Files\\dotnet" \
# DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false WINEDLLOVERRIDES="msquic=,mscoree=n,b" DOTNET_BUNDLE_EXTRACT_BASE_DIR=C:\\IINET\\ /home/faiyt/.xlcore/compatibilitytool/beta/wine-xiv-staging-fsync-git-7.10.r3.g560db77d/bin/wine64 /home/faiyt/.xlcore/wineprefix/drive_c/IINACT/IINACT.exe
