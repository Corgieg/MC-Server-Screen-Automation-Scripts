#!/bin/bash

# Configurable Variables Source
source ./server_config.sh

# Check if the screen socket exists, and execute if it does NOT
exists=$(screen -S $sSoc -Q select .)
if [[ "$exists" == *No\ screen\ session\ found.* ]]; then

 # Clear any dead screen sockets
 screen -wipe
 # Clear contents of the log file from previous socket
 truncate -s 0 $sLog
 # Create and detach from the socket for running the Minecraft server
 screen -L -Logfile $sLog -dmS $sSoc

else

 # Notice that the socket is running
 echo "Socket already exists"
 sleep 5

fi

exit


