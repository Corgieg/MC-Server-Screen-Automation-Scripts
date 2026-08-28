#!/bin/bash

# Configurable Variables Source
source ./server_config.sh

####################
# Screen Shutdown
####################
exists=$(screen -S $sSoc -Q select .)
if [[ "$exists" != *No\ screen\ session\ found.* ]]; then
 # Kill the screen socket
 screen -SX $sSoc quit
else
 echo "Socket does not exist. Exiting..."
 sleep 5
fi

exit 0
