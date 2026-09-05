#!/bin/bash

# This configuration file contains the configurable variables used by the other scripts for your convenience.
# Change the directories, file names, and other settings to suit your needs!

##### Server Settings #####
# Server Name
sName="MinecraftServer"
# Server World Folder Name
sWorld="world"
# Server Executable (Include file extension)
sExe="run.sh"
# Signal File (Include file extension)
sentinel="danger_zone.txt"
# Servers Root Directory (Full Path, include trailing slash)
rRoot="/home/minecraft/mcServers/"
# Scripts Root Directory (Full Path, include trailing slash)
tRoot="/home/minecraft/mcScripts/"

##### Screen Settings #####
# Server Socket Name
sSoc="minecraft"

##### Server Shutdown Settings #####
# Boolean - Enables World Backup After Shutdown (0 or 1)
backup=0
# Boolean - Enables Backup Removal After Shutdown (0 or 1)
remove=0
# Server Timer (In seconds | Must be a positive integer)
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

##### Server Backup Removal Settings #####
# Booleon - Enables Total Backup Removal (0 or 1)
purge=0
# Booleon - Enables Backup Removal: Arbitrary Monthly Schedule (0 or 1)
dMonthly=0
# Number Of Months To Backup (120-0 inclusive | 0 = current month)
nMonths=0
# Booleon - Enables Backup Removal: Arbitrary Daily Schedule (0 or 1)
dDaily=0
# Number Of Days To Backup (31-0 inclusive | 0 = current day)
nDays=0
# Keep Backup From Specific Day Each Month (31-0 inclusive | 0 = none)
kDOM=0

##### Directories & Executables #####
# Server Source Directory (Full path, include trailing slahs)
sDir="${rRoot}${sName}/server/"
# Backup Destination Directory (Full path, include trailing slash)
dDir="${rRoot}${sName}/backups/"
# Server Logs Directory (Full path, include trailing slash)
lDir="${rRoot}logs/"
# Screen Start Executable (Include file extension)
tExe="server_screen_start.sh"
# Screen Stop Executable (Include file extension)
pExe="server_screen_stop.sh"
# World Backup Executable (Include file extension)
bExe="server_backup.sh"
# Backup Removal Executable (Include file extension)
rExe="server_backup_removal.sh"
