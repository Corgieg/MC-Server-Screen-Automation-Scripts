#!/bin/bash

# Configurable Variables Source
source ./server_config.sh

# Server Save Command
mcSave="save-all"
# Server Stop Command
mcStop="stop"

# Initialize Time
time=$sTimer

# Check if screen socket exists, and execute if it does
exists=$(screen -S $sSoc -Q select .)
if [[ "$exists" != *No\ screen\ session\ found.* ]]; then

 # Greet players
 screen -S $sSoc -X stuff "`printf "say $mcGreeting\r"`";
 sleep 5

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
 $pExe
 
 # Execute world backup for the Minecraft server
 $bExe
 
else

 # Informs user that there is NO screen socket to terminate
 echo "Screen socket not running"
 sleep 5
 
fi

exit
