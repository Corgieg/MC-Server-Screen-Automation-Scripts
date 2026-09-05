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

if [[ ! -d "$tRoot" || -z "$tExe" || ! -f "${tRoot}${tExe}" ]]; then
 (( error+=1 ))
 errMessage+="Issue(s) - Scripts Root Directory or Screen Start Executable. Check the configuration, and ensure \"tRoot\" exists with \"tExe\" present."$'\n'
fi

if [[ ! -d "$sDir" || -z "$sExe" || ! -f "${sDir}${sExe}" ]]; then
 (( error+=1 ))
 errMessage+="Issue(s) - Source Directory or Server Start Executable. Check the configuration, and ensure \"sDir\" exists with \"sExe\" present."$'\n'
fi

if (( $error )); then
 echo "$errMessage"
 echo "Run the config inspector for more details. Exiting with $error errors..."$'\n'
 sleep 10
 exit 1
fi

####################
# Server Startup
####################
# Initialize the screen socket for the Minecraft server
${tRoot}${tExe}

exists=$(screen -S $sSoc -Q select .)
if [[ "$exists" == *No\ screen\ session\ found.* ]]; then
 echo "Screen socket not running. Start screen socket for the Minecraft server. Exiting..."
 sleep 5
 exit 0
fi

# Change screen to the directory of the Minecraft server
screen -S $sSoc -X stuff "`printf "cd '$sDir'\r"`";
# Execute run script to start the Minecraft server in the screen
screen -S $sSoc -X stuff "`printf "sh '${sDir}${sExe}'\r"`";

exit 0
