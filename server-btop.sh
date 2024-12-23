#!/bin/bash

# Start the SSH server
# ssh server "btop --utf-force"

kitty ssh -t server 'TERM=xterm-256color btop --utf-force; exec $SHELL'
# Run btop on the server using SSH
