#!/bin/sh



# Added to keyboard shortcut CTRL SHIFT ALT P => Kill top process
# script that can find the process that is using the most cpu

# get the process

# Get the process ID and CPU usage percentage for all processes
# Sort by CPU usage percentage in descending order
# Take only the first line, which will be the process with the highest CPU usage
# Extract the process ID and name using awk
top_process=$(ps aux --sort=-%cpu | head -n 2 | tail -n 1 | awk '{print $2, $11}')

top_processes=$(ps aux --sort=-%cpu | head -n 6 | tail -n +2 | awk '{print $2, $11}')
# Print the process ID and name
echo "Process with highest CPU usage: $top_process"
echo "Process with highest CPU usage: $top_processe     s"


# Terminate the process with the highest CPU usage

# Get the process ID from the first line of the output of the previous command
# Kill the process with the ID

kill -9 $(echo $top_process | awk '{print $1}')
echo "Killed process with ID $(echo $top_process | awk '{print $1}') and name $(echo $top_process | awk '{print $2}')"
# Log to a file the process that was killed
echo "Killed process with ID $(echo $top_process | awk '{print $1}') and name $(echo $top_process | awk '{print $2}')" >> /home/faiyt/scripts/kill.log
