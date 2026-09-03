#!/bin/bash

# This inspector verifies that the values passed to the various variables in the configureation are valid.

# Configurable Variables Source
source ./server_config.sh

# Errors Detected
error=0
# Error Message
errMessage="Error:"$'\n'
# RegEx (Matches on positive integers)
nRE='^[0-9]+$'

####################
# Names
####################
if [[ -z "$sSoc" ]]; then
 (( error+=1 ))
 errMessage+="\"sSoc\" null or unset."$'\n'
fi

if [[ -z "$sName" ]]; then
 (( error+=1 ))
 errMessage+="\"sName\" null or unset."$'\n'
fi

if [[ -z "$sWorld" ]]; then
 (( error+=1 ))
 errMessage+="\"sWorld\" null or unset."$'\n'
fi

if [[ -z "$sentinel" ]]; then
 (( error+=1 ))
 errMessage+="\"sentinel\" null or unset."$'\n'
fi

####################
# Backup Removal
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

####################
# Server Stop
####################
if [[ ! $backup =~ $nRE ]] || (( $backup != 1 && $backup != 0 )); then
 (( error+=1 ))
 errMessage+="\"backup\" not 0 or 1."$'\n'
fi

if [[ ! $remove =~ $nRE ]] || (( $remove != 1 && $remove != 0 )); then
 (( error+=1 ))
 errMessage+="\"remove\" not 0 or 1."$'\n'
fi

if [[ ! $sTimer =~ $nRE ]]; then
 (( error+=1 ))
 errMessage+="\"sTimer\" not positive integer."$'\n'
fi

if [[ -z "$mcGreeting" ]]; then
 (( error+=1 ))
 errMessage+="\"mcGreeting\" null or unset."$'\n'
fi

if [[ -z "$mcSaveMessage" ]]; then
 (( error+=1 ))
 errMessage+="\"mcSaveMessage\" null or unset."$'\n'
fi

if [[ -z "$mcSaveConfirm" ]]; then
 (( error+=1 ))
 errMessage+="\"mcSaveConfirm\" null or unset."$'\n'
fi

if [[ -z "$mcNotice" ]]; then
 (( error+=1 ))
 errMessage+="\"mcNotice\" null or unset."$'\n'
fi

if [[ -z "$mcStopMessage" ]]; then
 (( error+=1 ))
 errMessage+="\"mcStopMessage\" null or unset."$'\n'
fi

####################
# Directories
####################
if [[ ! -d "$tRoot" ]]; then
 (( error+=1 ))
 errMessage+="Unable to find Scripts Root Directory. Check \"tRoot\" in the configuration, and ensure the directory exists on the system."$'\n'
fi

if [[ ! -d "$rRoot" ]]; then
 (( error+=1 ))
 errMessage+="Unable to find Servers Root Directory. Check \"rRoot\" in the configuration, and ensure the directory exists on the system."$'\n'
fi

if [[ ! -d "$sDir" ]]; then
 (( error+=1 ))
 errMessage+="Unable to find Source Directory. Check \"sDir\" in the configuration, and ensure the directory exists on the system."$'\n'
fi

if [[ ! -d "$dDir" ]]; then
 (( error+=1 ))
 errMessage+="Unable to find Destination Directory. Check \"dDir\" in the configuration, and ensure the directory exists on the system."$'\n'
fi

if [[ ! -d "$lDir" ]]; then
 (( error+=1 ))
 errMessage+="Unable to find Log Directory. Check \"lDir\" in the configuration, and ensure the directory exists on the system."$'\n'
fi

####################
# Executables
####################
if [[ ! -z "$tExe" ]]; then
 (( error+=1 ))
 errMessage+="\"tExe\" null or unset."$'\n'
fi

if [[ ! -z "$sExe" ]]; then
 (( error+=1 ))
 errMessage+="\"sExe\" null or unset."$'\n'
fi

if [[ ! -z "$pExe" ]]; then
 (( error+=1 ))
 errMessage+="\"pExe\" null or unset."$'\n'
fi

if [[ ! -z "$bExe" ]]; then
 (( error+=1 ))
 errMessage+="\"bExe\" null or unset."$'\n'
fi

if [[ ! -z "$rExe" ]]; then
 (( error+=1 ))
 errMessage+="\"rExe\" null or unset."$'\n'
fi

####################
# Presence Checks
####################
if [[ ! -f "${tRoot}${tExe}" ]]; then
 (( error+=1 ))
 errMessage+="Screen Start Executable not in Scripts Root Directory. Add \"tExe\" to directory \"tRoot\"."$'\n'
fi

if [[ ! -f "${sDir}${sExe}" ]]; then
 (( error+=1 ))
 errMessage+="Server Executable not in Source Directory. Add \"sExe\" to directory \"sDir\"."$'\n'
fi

if [[ ! -f "${tRoot}${pExe}" ]]; then
 (( error+=1 ))
 errMessage+="Screen Stop Executable not in Scripts Root Directory. Add \"pExe\" to directory \"tRoot\"."$'\n'
fi

if [[ ! -f "${tRoot}${bExe}" ]]; then
 (( error+=1 ))
 errMessage+="World Backup Executable not in Scripts Root Directory. Add \"bExe\" to directory \"tRoot\"."$'\n'
fi

if [[ ! -f "${tRoot}${rExe}" ]]; then
 (( error+=1 ))
 errMessage+="Backup Removal Executable not in Scripts Root Directory. Add \"rExe\" to directory \"tRoot\"."$'\n'
fi

if [[ ! -f "${sDir}${sWorld}" ]]; then
 (( error+=1 ))
 errMessage+="Server's World Folder not in Source Directory. Add \"sWorld\" to directory \"sDir\"."$'\n'
fi

if [[ ! -f "${dDir}${sentinel}" ]]; then
 (( error+=1 ))
 errMessage+="Sentinel File not in Destination Directory. Add \"sentinel\" to directory \"dDir\"."$'\n'
fi

####################
# Message
####################
if (( $error )); then
 echo "$errMessage"
 echo "Exiting with $error errors..."$'\n'
else
 echo "No errors found in the configuration. Exiting..."
fi

sleep 30
exit 0
