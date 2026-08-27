#!/bin/bash

# Configurable Variables Source
source ./server_config.sh

# Current Date (YYYY-MM-DD)
cDate=$(date +%Y-%m-%d)
# Destination Archive Name Utilizing World Name & Current Date
zBackup="$sWorld-$cDate"

# Checks if the signal file is present
if [[ ! -f "$dDir$signal" ]]; then
 # Informs user that there is NO signal file in the target directory
 echo "Signal file not found in destination directory. Exiting..."
 sleep 5
 exit 1
fi

# Change the active directory to the server folder
cd "$sDir"
# Compress the current contents of the server world folder into a new backup folder
zip -r "$dDir$zBackup.zip" "$sWorld"

exit 0
