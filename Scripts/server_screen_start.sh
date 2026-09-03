#!/bin/bash

# Configurable Variables Source
source ./server_config.sh

# Errors Detected
error=0
# Error Message
errMessage="Error:"$'\n'

####################
# Error Handling
####################
if [[ -z "$sSoc" ]]; then
 (( error+=1 ))
 errMessage+="\"sSoc\" null or unset."$'\n'
fi

if [[ -z "$sName" ]]; then
 (( error+=1 ))
 errMessage+="\"sName\" null or unset."$'\n'
fi

if [[ ! -d "$lDir" ]]; then
 (( error+=1 ))
 errMessage+="Unable to find Log Directory. Check \"lDir\" in the configuration, and ensure the directory exists on the system."$'\n'
fi

if (( $error )); then
 echo "$errMessage"
 echo "Exiting with $error errors..."$'\n'
 sleep 10
 exit 1
fi

####################
# Screen Startup
####################
exists=$(screen -S $sSoc -Q select .)
if [[ "$exists" != *No\ screen\ session\ found.* ]]; then
 echo "Socket already exists or Screen is not installed. Exiting..."
 sleep 5
 exit 0
fi

log="${lDir}${sName}_log.txt"
# Clear any dead screen sockets
screen -wipe
# Clear contents of the log file from previous socket
truncate -s 0 $log
# Create and detach from the socket for running the Minecraft server and assign its log file
screen -L -Logfile $log -dmS $sSoc

exit 0
