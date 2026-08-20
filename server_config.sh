#!/bin/bash

# This configuration file contains the configurable variables used by the other scripts for your convenience.
# Change the directories, file names, and other settings to suit your needs!

### Server Settings ###
# Server Name
sName="MinecraftServer"
# Server World Folder Name
sWorld="world"
# Server Executable Name (Include file extension)
sExe="run.sh"
# Signal File Name (Include file extension)
signal="danger_zone.txt"
# Server Log File Name (Include file extension)
log="server_log.txt"
# Servers Root Directory (Full Path)
rRoot="/home/minecraft/mcServers/"
# Scripts Root Directory (Full Path)
tRoot="/home/minecraft/scripts/"

### Screen Settings ###
# Server Socket Name
sSoc="minecraft"

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

### Directories & Executables ###
# Server Directory (Full path)
sDir="$rRoot$sName/server/"
# Backup Destination Directory (Full path)
dDir="$rRoot$sName/backups/"
# Server Log Directory (Full path)
sLog="'$rRoot'serverActivity/$log"
# Screen Start Executable (Full path)
tExe="'$tRoot'server_screen_start.sh"
# Screen Stop Executable (Full path)
pExe="'$tRoot'server_screen_stop.sh"
# World Backup Executable (Full path)
bExe="'$tRoot'server_backup.sh"
