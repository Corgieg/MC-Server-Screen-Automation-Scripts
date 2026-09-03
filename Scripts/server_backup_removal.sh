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
if [[ ! $purge =~ $nRE ]] || (( $purge != 1 && $purge != 0 )); then
 (( error+=1 ))
 errMessage+="\"purge\" not 0 or 1."$'\n'
fi

if [[ ! $dMonthly =~ $nRE ]] || (( $dMonthly != 1 && $dMonthly != 0 )); then
 (( error+=1 ))
 errMessage+="\"dMonthly\" not 0 or 1."$'\n'
fi

if [[ ! $dDaily =~ $nRE ]] || (( $dDaily != 1 && $dDaily != 0 )); then
 (( error+=1 ))
 errMessage+="\"dDaily\" not 0 or 1."$'\n'
fi

if [[ ! $nMonths =~ $nRE ]] || (( $nMonths > 120 || $nMonths < 0 )); then
 (( error+=1 ))
 errMessage+="\"nMonths\" beyond accepted range or invalid. Set between 0 and 120 inclusive."$'\n'
fi

if [[ ! $nDays =~ $nRE ]] || (( $nDays > 31 || $nDays < 0 )); then
 (( error+=1 ))
 errMessage+="\"nDays\" beyond accepted range or invalid. Set between 0 and 31 inclusive."$'\n'
fi

if [[ ! $kDOM =~ $nRE ]] || (( $kDOM > 31 || $kDOM < 0 )); then
 (( error+=1 ))
 errMessage+="\"kDOM\" beyond accepted range or invalid. Set between 0 and 31 inclusive."$'\n'
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
# Backup Removal Scheduling
####################
# Change the active directory to the server backups folder
cd "$dDir"
# Enables the Extended Pattern Matching extension
shopt -s extglob

####################
# Purge
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
 # schedule is converted to a space delineated string for comparison
 if [[ ! " ${schedule[*]} " =~ " $file " ]] && [[ -f "$file" ]]; then
  rm $file
 fi
done

exit 0
