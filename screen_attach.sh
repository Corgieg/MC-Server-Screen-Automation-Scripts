#!/bin/bash

# Configurable Variables Source
source ./server_config.sh

# Check if the screen socket exists, and execute if it does
exists=$(screen -S $sSoc -Q select .)
if [[ "$exists" != *No\ screen\ session\ found.* ]]; then

 # Attach to the screen socket of the Minecraft server
 screen -r $sSoc

else

 # Notice that the socket is NOT running
 echo "Socket does not exist"
 sleep 5

fi

exit
