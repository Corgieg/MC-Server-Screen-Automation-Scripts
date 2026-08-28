#!/bin/bash

# Configurable Variables Source
source ./server_config.sh

####################
# Screen Startup
####################
exists=$(screen -S $sSoc -Q select .)
if [[ "$exists" == *No\ screen\ session\ found.* ]]; then
 # Clear any dead screen sockets
 screen -wipe
 # Clear contents of the log file from previous socket
 truncate -s 0 $log
 # Create and detach from the socket for running the Minecraft server and assign its log file
 screen -L -Logfile $log -dmS $sSoc
else
 echo "Socket already exists. Exiting..."
 sleep 5
fi

exit 0


