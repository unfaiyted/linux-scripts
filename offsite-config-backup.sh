#!/bin/sh

# Stop all docker services
docker-compose down

# Backup the folder using rclone


# Config Folder
rclone sync /media/faiyt/f/config/ personal:/server-config --progress --log-file=./rclone-config.log
# Scripts Folder
rclone sync /home/faiyt/scripts/ personal:/scripts --progress --log-file=./rclone-scripts.log


# Check if the backup was successful
if [ $? -eq 0 ]; then
  echo "Backup completed successfully!"
else
  echo "Backup failed. Check rclone.log for more information."
  # Send a notification using your preferred method, e.g. email or SMS
  # Replace <notification command> with the appropriate command for your notification service
  # <notification command> "Backup failed. Check /var/log/rclone.log for more information."
fi

docker-compose up
