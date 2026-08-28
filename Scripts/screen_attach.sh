#!/bin/bash

# Configurable Variables Source
source ./server_config.sh

####################
# Screen Attatch
####################
exists=$(screen -S $sSoc -Q select .)
if [[ "$exists" != *No\ screen\ session\ found.* ]]; then
 # Attach to the screen socket of the Minecraft server
 screen -r $sSoc
else
 echo "Socket does not exist. Exiting..."
 sleep 5
fi

exit 0
