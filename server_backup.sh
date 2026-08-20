#!/bin/bash

# Configurable Variables Source
source ./server_config.sh

# Current Date (YYYY-MM-DD)
cDate=$(date +%Y-%m-%d)
# Current Year
cYear=$(date +%Y)
# Current Month
cMonth=$(date +%m)
# Current Day
cDay=$(date +%d)
# First Of A Month
fDay="01"
# 1 Day Ago
iDay=$(date -d "1 day ago" +%d)
# 2 Days Ago
iiDay=$(date -d "2 day ago" +%d)
# 3 Days Ago
iiiDay=$(date -d "3 day ago" +%d)
# 4 Days Ago
ivDay=$(date -d "4 day ago" +%d)
# Destination File Name Utilizing World Name & Current Date
zBackup="'$sWorld'_$cDate"

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

# Change the active directory to the server backups folder
cd "$dDir"

# Extension required for rm to allow inverted check
shopt -s extglob

# Deletes all folders and their contents that do NOT contain the current year. Also excludes the signal file from deletion
rm -rf !(*_$cYear-*|$signal)
 
# Deletes all folders and their contents that do NOT contain the current day, previous 4 days, or that are NOT the first day of a month. Also excludes the signal file from deletion
rm -rf !(*-$fDay*|*-$cDay*|*-$iDay*|*-$iiDay*|*-$iiiDay*|*-$ivDay*|$signal)

exit
