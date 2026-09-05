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
if [[ ! -d "$sDir" || -z "$sWorld" || ! -d "${sDir}${sWorld}" ]]; then
 (( error+=1 ))
 errMessage+="Issue(s) - Source Directory or Server's World Folder. Check the configuration, and ensure \"sDir\" exists with \"sWorld\" present."$'\n'
fi

if [[ ! -d "$dDir" || -z "$sentinel" || ! -f "${dDir}${sentinel}" ]]; then
 (( error+=1 ))
 errMessage+="Issue(s) - Destination Directory or Sentinel File. Check the configuration, and ensure \"dDir\" exists with \"sentinel\" present."$'\n'
fi

if (( $error )); then
 echo "$errMessage"
 echo "Run the config inspector for more details. Exiting with $error errors..."$'\n'
 sleep 10
 exit 1
fi

####################
# Server Backup
####################
# Current Date (YYYY-MM-DD)
cDate=$(date +%Y-%m-%d)

# Change the active directory to the server folder
cd "$sDir"
# Compress the current contents of the server's world folder into a new backup folder
zip -r "${dDir}${sWorld}-${cDate}.zip" "$sWorld"

exit 0
