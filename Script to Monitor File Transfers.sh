#!/bin/bash

WATCH_DIR="/sensitive_data"
LOG_FILE="/var/log/file_transfer.log"

inotifywait -m -e create,move,delete $WATCH_DIR |
while read path action file; do
  echo "$(date): File '$file' in '$path' was $action" >> $LOG_FILE
done
: << 'COMMENT'

Explanation:

inotifywait: Monitors the directory for changes (e.g., file creation, movement, or deletion).
$WATCH_DIR: Directory being monitored.
$LOG_FILE: Logs events with timestamps.
Purpose: Helps detect unauthorized file movements, which is critical for DLP monitoring.
