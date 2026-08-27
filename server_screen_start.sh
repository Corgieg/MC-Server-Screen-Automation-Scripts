#!/bin/bash

# Configurable Variables Source
source ./server_config.sh

# Check if the screen socket exists, and execute if it does NOT
exists=$(screen -S $sSoc -Q select .)
if [[ "$exists" == *No\ screen\ session\ found.* ]]; then
 # Clear any dead screen sockets
 screen -wipe
 # Clear contents of the log file from previous socket
 truncate -s 0 $log
 # Create and detach from the socket for running the Minecraft server
 screen -L -Logfile $log -dmS $sSoc
else
 # Notice that the socket is running
 echo "Socket already exists"
 sleep 5
fi

exit 0


