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
This script gracefully stops and saves the server and then calls the screen stop script to kill the screen socket. Once that is finished, it calls the server backup script.

# 5. Server Backup
This script creates an archive of the server's world data and saves that archive to a separate directory. The archives are automatically named with the current date. The archives name is used to determine when that backup should be deleted. Currently, the script keeps backups for the last 5 days, and a backup from the start of each month. Backups are deleted at the start of each year.

# 6. Screen attach
This script attaches a terminal instance to the running server socket so the user can actively monitor the feed and execute commands directly. If the socket does not exist, the user is notified and exits.
