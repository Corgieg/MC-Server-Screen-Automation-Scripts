#!/bin/bash

# Configurable Variables Source
source ./server_config.sh

# Check if the screen socket exists, and execute if it does
exists=$(screen -S $sSoc -Q select .)
if [[ "$exists" != *No\ screen\ session\ found.* ]]; then
 # Kill the screen socket
 screen -SX $sSoc quit
else
 # Notice that the socket is NOT running
 echo "Socket does not exist"
 sleep 5
fi

exit 0
