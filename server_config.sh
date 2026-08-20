#!/bin/bash

# This configuration file contains the configurable variables used by the other scripts for your convenience.

### Server Settings ###
# Server Name
sName="Mine-n-Blade"
# Server Directory (Full path)
sDir="/home/minecraft/MC Servers/$sName/Server/"
# Server Executable Name (Include file extension)
sExe="run.sh"
# Backup Source folder Name
sFile="world"
# Backup Destination Directory (Full path)
dDir="/home/minecraft/MC Servers/$sName/Backups/"
# World Backup Executable (Full path)
bExe="/home/minecraft/Scripts/server_backup.sh"

### Screen Settings ###
# Server Socket Name
sSoc="minecraft"
# Screen Start Executable (Full path)
tExe="/home/minecraft/Scripts/server_screen_start.sh"
# Screen Stop Executable (Full path)
pExe="/home/minecraft/Scripts/server_screen_stop.sh"

### Other Files ###
# Server Log (Full path)
sLog="/home/minecraft/Desktop/ServerActivity/ServerLog.txt"
# Signal File Name (Include file extension)
sTxt="danger_zone.txt"

### Server Shutdown Settings ###
# Server Timer
sTimer=30
# Server Shutdown Greetings Text
mcGreeting="GREETINGS, THE DAILY SHUTDOWN WILL COMMENCE SHORTLY"
# Server Save Message Text
mcSaveMessage="SAVING WORLD..."
# Server Save Confirmation Text
mcSaveConfirm="WORLD SAVE COMPLETED"
# Server Shutdown Sequence Notice Text
mcNotice="SHUTDOWN TIMER START"
# Server Stop Message Text
mcStopMessage="SHUTTING DOWN..."
