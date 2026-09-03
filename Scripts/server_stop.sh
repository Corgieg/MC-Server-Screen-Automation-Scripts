#!/bin/bash

# Configurable Variables Source
source ./server_config.sh

# Server Save Command
mcSave="save-all"
# Server Stop Command
mcStop="stop"
# Errors Detected
error=0
# Error Message
errMessage="Error:"$'\n'
# RegEx (Matches on positive integers)
nRE='^[0-9]+$'

####################
# Error Handling
####################
if [[ -z "$sSoc" ]]; then
 (( error+=1 ))
 errMessage+="\"sSoc\" null or unset."$'\n'
fi

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

if [[ -z "$mcGreeting" || -z "$mcSaveMessage" || -z "$mcSaveConfirm" || -z "$mcNotice" || -z "$mcStopMessage" ]]; then
 (( error+=1 ))
 errMessage+="Issue(s) - one or more Server Message Variables."$'\n'
fi

if [[ ! -d "$tRoot" || ! -z "$pExe" || ! -f "${tRoot}${pExe}" ]]; then
 (( error+=1 ))
 errMessage+="Issue(s) - Scripts Root Directory or Screen Stop Executable. Check the configuration, and ensure \"tRoot\" exists with \"pExe\" present."$'\n'
fi

if (( $error )); then
 echo "$errMessage"
 echo "Run the config inspector for more details. Exiting with $error errors..."$'\n'
 sleep 10
 exit 1
fi

####################
# Server Shutdown
####################
exists=$(screen -S $sSoc -Q select .)
if [[ "$exists" == *No\ screen\ session\ found.* ]]; then
 echo "Screen socket not running. Exiting..."
 sleep 5
 exit 0
fi

# Greet players
screen -S $sSoc -X stuff "`printf "say $mcGreeting\r"`";
sleep 5

# Initialize Time
time=$sTimer
# Loop to warn players of world save
while ((time > 0))
do
 screen -S $sSoc -X stuff "`printf "say WORLD SAVE IN $time SECONDS\r"`";
 sleep 5
 ((time-=5))
done

# Inform players the world state is being saved
screen -S $sSoc -X stuff "`printf "say $mcSaveMessage\r"`";
sleep 5
# Save the Minecraft server world state to disk
screen -S $sSoc -X stuff "`printf "$mcSave\r"`";
# Inform players the world state has been saved
screen -S $sSoc -X stuff "`printf "say $mcSaveConfirm\r"`";

# Delay between world save and server shutdown
sleep 5
screen -S $sSoc -X stuff "`printf "say $mcNotice\r"`";
sleep 5

# Reset Time
time=$sTimer
# Loop to warn players of server shutdown
while ((time > 0))
do
 screen -S $sSoc -X stuff "`printf "say SCHEDULED SHUTDOWN IN $time SECONDS\r"`";
 sleep 5
 ((time-=5))
done

# Inform players the server is shutting down
screen -S $sSoc -X stuff "`printf "say $mcStopMessage\r"`";
sleep 5
# Shutdown the Minecraft server
screen -S $sSoc -X stuff "`printf "$mcStop\r"`";

# Kill the Minecraft server screen socket
${tRoot}${pExe}

# Execute world backup for the Minecraft server if backup is enabled
if (( $backup )); then
 if [[ ! -z "$bExe"  || ! -f "${tRoot}${bExe}" ]]; then
  echo "Issue(s) - World Backup Executable. Run the config inspector for more details. Exiting..."
  sleep 5
  exit 1
 fi
 $bExe
fi

 # Execute backup removal for the Minecraft server if remove is enabled
if (( $remove )); then
 if [[ ! -z "$rExe"  || ! -f "${tRoot}${rExe}" ]]; then
  echo "Issue(s) - Backup Removal Executable. Run the config inspector for more details. Exiting..."
  sleep 5
  exit 1
 fi
 $rExe
fi

exit 0
