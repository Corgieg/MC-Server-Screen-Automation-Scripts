# Minecraft Server Automation Using GNU Screen Multiplexer

The scripts can be set to execute on a regular basis using Cron jobs, Systemd Timers, or similar tools.

Below are descriptions of what each of the current scripts do:
# 1. Server Screen Start
This script simply creates a screen using the socket name provided by the config file and attaches a log file to the screen using the log file name from the config. If a screen using that name already exists, the script notifies the user and exits.

# 2. Server Screen Stop
This script kills the socket with the name given by the config file. If no socket with that name exits, it notifies the user and exits.

# 3. Server Start
This script runs the screen start script and then runs the server's executable from that screen.

# 4. Server Stop
This script gracefully stops and saves the server and then calls the screen stop script to kill the screen socket. Optionally, it can call the backup and backup removal scripts as well.

# 5. Server Backup
This script creates an archive of the server's world data and saves that archive to a separate directory designated in the config. The archives are automatically named with the current date (WorldName-YYYY-MM-DD). If the signal file designated in the config is not present in the destination directory, the script will not create a backup archive.

# 6. Server Backup Removal
This script checks the archives in the backup destination directory, and deletes them based on criteria set in the config. If the signal file designated in the config is not present in the destination directory, this script will not run.
  - Purge: If enabled, all files in the destination directory other than the signal file will be deleted.
  - dMonthly: If enabled, files will be deleted according to nMonths.
  - nMonths: The number of months that archives should be kept; 0 is current month only. Any archive older than N months will be deleted regardless of other settings
  - dDaily: If enabled, files will be deleted according to nDays.
  - nDays: The number of days that archives should be kept. Will deleted archives from previous months as well. Used for keeping a small number of rolling daily backups.
  - kDOM: Designates a day each month for which older archives should be kept. Used to keep a single monthly archive from prior months in conjunction with archives set by nDays. Will be kept indefinitely or back to nMonths depending on how dMonthly and nMonths are configured.

# 7. Screen attach
This script attaches a terminal instance to the running server socket so the user can actively monitor the feed and execute commands directly. If the socket does not exist, the user is notified and exits.
