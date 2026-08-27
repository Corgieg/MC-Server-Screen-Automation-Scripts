#!/bin/bash

# Configurable Variables Source
source ./server_config.sh

# Checks if nMonths has a valid value
if (( $nMonths > 120 | $nMonths < 0 )); then
 # Informs user that nMonths is invalid
 echo "nMonths is outside of the accepted range or invalid. Please, set between 0 and 120 inclusive"
 sleep 5
 exit 1
fi
# Checks if nDays has a valid value
if (( $nDays > 31 | $nDays < 0 )); then
 # Informs user that nDays is invalid
 echo "nDays is outside of the accepted range or invalid. Please, set between 0 and 31 inclusive"
 sleep 5
 exit 1
fi
# Checks if the signal file is present
if [[ ! -f "$dDir$signal" ]]; then
 # Informs user that there is NO signal file in the target directory
 echo "Signal file not found in destination directory. Exiting..."
 sleep 5
 exit 1
fi

# Change the active directory to the server backups folder
cd "$dDir"
# Enables the Extended Pattern Matching extension
shopt -s extglob

# Checks if removal of all backups has been enabled
if (( $purge )); then
 rm -rf !($signal)
 exit 0
fi

####################
# Monthly
####################
# Checks if arbitrary monthly backups have been enabled
if (( $dMonthly )); then
 # Initialize the list for determining which files meet any monthly criteria
 mSchedule=($signal)
 # Loops through the set number of months to gather the dates that should be kept
 while (( $nMonths >= 0 ))
  do
  mSchedule+=(*-$(date -d "$nMonths month ago" +%Y-%m)-*)
  (( nMonths-=1 ))
 done
 # Checks each file in the directory and deletes any that are not present in the monthly schedule
 # BE AWARE: any backups beyond the specified number of months will be deleted regardless of if kDOM is set
 for file in *; do
  # mSchedule is converted to a space delineated string for comparison
  if [[ ! " ${mSchedule[*]} " =~ " $file " ]] && [[ -f "$file" ]]; then
   rm $file
  fi
 done
fi

####################
# Daily & D.O.M.
####################
# Checks if arbitrary daily backups have been enabled or if a specific day each month has been set
if (( $dDaily | $kDOM )); then
 # Initialize the list for determining which files meet any per day criteria
 dSchedule=($signal)
 # Checks if a specific day each month has been set
 if (( $kDOM <= 31 | $kDOM >= 1)); then
  # If the specified day is single digit, add a leading 0 to match the naming convention
  if (( $kDOM < 10 )); then
   dSchedule+=(*-0$kDOM.*)
  else
   dSchedule+=(*-$kDOM.*)
  fi
 fi
 # Checks if arbitrary daily backups have been enabled
 if (( $dDaily )); then
  # Loops through the set number of days to gather the dates that should be kept
  while (( $nDays >= 0 ))
   do
   dSchedule+=(*-$(date -d "$nDays day ago" +%m-%d).*)
   (( nDays-=1 ))
  done
 fi
 # Checks each file in the directory and deletes any that are not present in the daily schedule
 # Daily schedule includes: signal file, backups that match kDOM if set, and dates that match nDays if set
 for file in *; do
  # dSchedule is converted to a space delineated string for comparison
  if [[ ! " ${dSchedule[*]} " =~ " $file " ]] && [[ -f "$file" ]]; then
   rm $file
  fi
 done
fi

exit 0
