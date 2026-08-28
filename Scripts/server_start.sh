#!/bin/bash

# Configurable Variables Source
source ./server_config.sh

# Initialize the screen socket for the Minecraft server
$tExe

####################
# Server Startup
####################
exists=$(screen -S $sSoc -Q select .)
if [[ "$exists" != *No\ screen\ session\ found.* ]]; then
 # Change screen to the directory of the Minecraft server
 screen -S $sSoc -X stuff "`printf "cd '$sDir'\r"`";
 # Execute run script to start the Minecraft server in the screen
 screen -S $sSoc -X stuff "`printf "sh '$sDir$sExe'\r"`";
else
 echo "Screen socket not running, please start up the screen socket for the Minecraft server. Exiting..."
 sleep 5
fi

exit 0
