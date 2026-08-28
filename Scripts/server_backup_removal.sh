#!/bin/bash

# Configurable Variables Source
source ./server_config.sh

# Errors Detected
error=0
# Error Message
errMessage="Error:"$'\n'
# RegEx (Matches on positive integers)
nRE='^[0-9]+$'

####################
# Error Handling
####################
if (( $purge != 1 && $purge != 0 )); then
 (( error+=1 ))
 errMessage+="purge is not set to 0 or 1."$'\n'
fi

if (( $dMonthly != 1 && $dMonthly != 0 )); then
 (( error+=1 ))
 errMessage+="dMonthly is not set to 0 or 1."$'\n'
fi

if (( $dDaily != 1 && $dDaily != 0 )); then
 (( error+=1 ))
 errMessage+="dDaily is not set to 0 or 1."$'\n'
fi

if [[ ! $nMonths =~ $nRE ]] || (( $nMonths > 120 || $nMonths < 0 )); then
 (( error+=1 ))
 errMessage+="nMonths is outside of the accepted range or invalid. Set between 0 and 120 inclusive."$'\n'
fi

if [[ ! $nDays =~ $nRE ]] || (( $nDays > 31 || $nDays < 0 )); then
 (( error+=1 ))
 errMessage+="nDays is outside of the accepted range or invalid. Set between 0 and 31 inclusive."$'\n'
fi

if [[ ! $kDOM =~ $nRE ]] || (( $kDOM > 31 || $kDOM < 0 )); then
 (( error+=1 ))
 errMessage+="kDOM is outside of the accepted range or invalid. Set between 0 and 31 inclusive."$'\n'
fi

if (( $error )); then
 echo "$errMessage"
 echo "Exiting with $error errors..."$'\n'
 sleep 5
 exit 1
fi

if [[ ! -f "${dDir}${sentinel}" ]]; then
 echo "Sentinel file not found in destination directory. Exiting..."
 sleep 5
 exit 0
fi

# Change the active directory to the server backups folder
cd "$dDir"
# Enables the Extended Pattern Matching extension
shopt -s extglob

####################
# Purge Backups
####################
if (( $purge )); then
 rm -rf !($sentinel)
 exit 0
fi

####################
# Monthly
####################
if (( $dMonthly )); then
 mSchedule=($sentinel)
 # Loops through the set number of months to gather the dates that should be kept
 while (( $nMonths >= 0 ))
  do
  mSchedule+=(*-$(date -d "$nMonths month ago" +%Y-%m)-*)
  (( nMonths-=1 ))
 done
fi

####################
# Daily & D.O.M.
####################
if (( $dDaily || $kDOM )); then
 dSchedule=($sentinel)
 if (( $kDOM )); then
  # If the specified day is single digit, add a leading 0 to match the naming convention
  if (( $kDOM < 10 )); then
   dSchedule+=(*-0$kDOM.*)
  else
   dSchedule+=(*-$kDOM.*)
  fi
 fi

 if (( $dDaily )); then
  # Loops through the set number of days to gather the dates that should be kept
  while (( $nDays >= 0 ))
   do
   dSchedule+=(*-$(date -d "$nDays day ago" +%m-%d).*)
   (( nDays-=1 ))
  done
 fi
fi

####################
# Remove Unscheduled Backups
####################
if [[ $mSchedule && $dSchedule ]]; then
 # Utilizes process substitution and the comm command to find common elements between the daily and monthly schedules
 schedule=( $(comm -12 <(printf "%s\n" "${mSchedule[@]}" | sort) <(printf "%s\n" "${dSchedule[@]}" | sort)) )
 unset mSchedule
 unset dSchedule
elif [[ $mSchedule ]]; then
 schedule=(${mSchedule[@]})
 unset mSchedule
elif [[ $dSchedule ]]; then
 schedule=(${dSchedule[@]})
 unset dSchedule
else
 echo "No schedule set. Exiting..."
 sleep 5
 exit 0
fi

# Checks each file in the directory and deletes any that are not present in the schedule
for file in *; do
 # dSchedule is converted to a space delineated string for comparison
 if [[ ! " ${schedule[*]} " =~ " $file " ]] && [[ -f "$file" ]]; then
  rm $file
 fi
done

exit 0
