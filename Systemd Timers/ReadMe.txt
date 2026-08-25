----------
Here are some basic instructions for setting up the systemd timers
----------

1. Add service and timer files to directory:
        /etc/systemd/system/

2. Execute:
        systemd-analyze verify /etc/systemd/system/TIMER.*
            - This will verify that there are no issues with the files
            - Will need to be run for each pair of files: server-stop, server-start, etc.

3. Execute:
        sudo systemctl start TIMER.timer
            - This will start the timer for the current session

4. Execute:
    sudo systemctl enable TIMER.timer
        - This will ensure the timer starts whenever the system boots

----------
Additional Commands
----------

Check timer's status:
    sudo systemctl status TIMER.timer

Reload daemon to update timer if the service file was modified:
    systemctl daemon-reload

Starting and stopping timer:
    sudo systemctl start TIMER.timer
    sudo systemctl restart TIMER.timer
    sudo systemctl stop TIMER.timer

Enabling and disabling timer:
    sudo systemctl enable TIMER.timer
    sudo systemctl disable TIMER.timer

List all active timers
    sudo systemctl list-timers