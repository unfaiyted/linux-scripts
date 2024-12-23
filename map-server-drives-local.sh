#!/bin/bash

cd "$(dirname "$0")" || exit
sudo sshfs -o allow_other,IdentityFile=/home/faiyt/.ssh/id_rsa faiyt@192.168.0.120:/ /mnt/server/
#sudo sshfs -o allow_other,IdentityFile=/home/faiyt/.ssh/id_rsa faiyt@192.168.0.120:/media/faiyt/f/config /media/faiyt/f/config

# sudo sshfs -o allow_other,IdentityFile=/home/faiyt/.ssh/id_rsa faiyt@192.168.0.120:/media/faiyt/f/movies /media/faiyt/f/movies
# sudo sshfs -o allow_other,IdentityFile=/home/faiyt/.ssh/id_rsa faiyt@192.168.0.120:/media/faiyt/f/downloads /media/faiyt/f/downloads

# sudo sshfs -o allow_other,IdentityFile=/home/faiyt/.ssh/id_rsa faiyt@192.168.0.120:/media/faiyt/e/movies /media/faiyt/e/movies
# sudo sshfs -o allow_other,IdentityFile=/home/faiyt/.ssh/id_rsa faiyt@192.168.0.120:/media/faiyt/e/tv /media/faiyt/e/tv

# sudo sshfs -o allow_other,IdentityFile=/home/faiyt/.ssh/id_rsa faiyt@192.168.0.120:/media/faiyt/g/movies /media/faiyt/g/movies
# sudo sshfs -o allow_other,IdentityFile=/home/faiyt/.ssh/id_rsa faiyt@192.168.0.120:/media/faiyt/d/tv /media/faiyt/d/tv
# sudo sshfs -o allow_other,IdentityFile=/home/faiyt/.ssh/id_rsa faiyt@192.168.0.120:/media/faiyt/h/tv /home/faiyt/h-tv/

# sudo sshfs -o allow_other,IdentityFile=/home/faiyt/.ssh/id_rsa faiyt@192.168.0.120:/media/faiyt/i/anime /home/faiyt/drive_i/anime
# sudo sshfs -o allow_other,IdentityFile=/home/faiyt/.ssh/id_rsa faiyt@192.168.0.120:/media/faiyt/e/games /home/faiyt/drive_e/games

# sudo sshfs -o allow_other,IdentityFile=/home/faiyt/.ssh/id_rsa faiyt@192.168.0.120:/media/faiyt/i1/downloads/home/faiyt/drive_i/downloads
