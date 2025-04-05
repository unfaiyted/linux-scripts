#!/bin/bash

# Create mount points if they don't exist
sudo mkdir -p /mnt/downloads         # download drive
sudo mkdir -p /mnt/raid              # raid array
sudo mkdir -p /mnt/server109/config  # web server
sudo mkdir -p /mnt/server110/config  # media
sudo mkdir -p /mnt/server101/config  # download
sudo mkdir -p /mnt/server123/config  # apps
sudo mkdir -p /mnt/playground/config # apps
sudo mkdir -p /mnt/vps/config

# Mount the Samba share from 192.168.0.109
sudo mount -t cifs //192.168.0.109/config /mnt/server109/config -o credentials=/home/faiyt/.creds/root,uid=faiyt,gid=faiyt
sudo mount -t cifs //192.168.0.101/config /mnt/server101/config -o credentials=/home/faiyt/.creds/faiyt
sudo mount -t cifs //192.168.0.110/config /mnt/server110/config -o credentials=/home/faiyt/.creds/faiyt
sudo mount -t cifs //192.168.0.123/config /mnt/server123/config -o credentials=/home/faiyt/.creds/faiyt
# sudo mount -t cifs //192.168.0.231/config /mnt/playgrounjd/config -o credentials=/home/faiyt/.creds/faiyt
sudo mount -t cifs //192.168.0.231/config /mnt/playground/config -o credentials=/home/faiyt/.creds/faiyt,uid=faiyt,gid=faiyt

sudo mount -t nfs 192.168.0.101:/mnt/downloads /mnt/downloads
sudo mount -t nfs 192.168.0.110:/mnt/raid /mnt/raid


# ssh -L 2049:localhost:2049 -L 111:localhost:111 user@your_server_ip -N
# sudo mount -t nfs 209.74.71.189:/config /mnt/vps/config

 sshfs root@209.74.71.189:/config /mnt/vps/config -p 22022 -o reconnect,compression=yes,cache=yes,IdentityFile=~/.ssh/id_ecdsa



# Check if mount was successful
if mountpoint -q /mnt/server109/config; then
  echo "Successfully mounted /config from 192.168.0.109"
else
  echo "Failed to mount /config from 192.168.0.109"
fi

if mountpoint -q /mnt/server110/config; then
  echo "Successfully mounted /config from 192.168.0.110"
else
  echo "Failed to mount /config from 192.168.0.110"
fi

if mountpoint -q /mnt/server101/config; then
  echo "Successfully mounted /config from 192.168.0.101"
else
  echo "Failed to mount /config from 192.168.0.101"
fi

if mountpoint -q /mnt/server123/config; then
  echo "Successfully mounted /config from 192.168.0.123"
else
  echo "Failed to mount /config from 192.168.0.123"
fi

if mountpoint -q /mnt/downloads; then
  echo "Successfully mounted /mnt/downloads from 192.168.0.101"
else
  echo "Failed to mount /mnt/downloads from 192.168.0.101"
fi

if mountpoint -q /mnt/raid; then
  echo "Successfully mounted /mnt/raid from 192.168.0.110"
else
  echo "Failed to mount /mnt/raid from 192.168.0.110"
fi

if mountpoint -q /mnt/playground/config; then
  echo "Successfully mounted /config from 192.168.0.231"
else
  echo "Failed to mount /config from 192.168.0.231"
fi

if mountpoint -q /mnt/vps/config; then
  echo "Successfully mounted /mnt/vps from 209.74.71.189"
else
  echo "Failed to mount /mnt/vps from 209.74.71.189"
fi

# Template for additional servers:
# sudo mkdir -p /mnt/serverXXX/sharename
# sudo mount -t cifs //192.168.0.XXX/sharename /mnt/serverXXX/sharename -o username=USER,password=PASS
