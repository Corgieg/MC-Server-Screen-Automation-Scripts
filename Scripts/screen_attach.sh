#!/bin/bash

# Configurable Variables Source
source ./server_config.sh

####################
# Error Handling
####################
if [[ -z "$sSoc" ]]; then
 echo "\"sSoc\" null or unset. Exiting..."
 sleep 5
 exit 1
fi

####################
# Screen Attatch
####################
exists=$(screen -S $sSoc -Q select .)
if [[ "$exists" == *No\ screen\ session\ found.* ]]; then
 echo "Socket does not exist. Exiting..."
 sleep 5
 exit 0
fi

# Attach to the screen socket of the Minecraft server
screen -r $sSoc

exit 0
