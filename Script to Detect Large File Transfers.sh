#!/bin/bash

LOG_FILE="/var/log/large_transfer.log"
THRESHOLD=100000000 # 100 MB in bytes

lsof -i -n | grep 'ESTABLISHED' |
while read line; do
  pid=$(echo $line | awk '{print $2}')
  bytes_sent=$(cat /proc/$pid/net/dev | awk '/eth0/ {print $10}')
  if [ $bytes_sent -gt $THRESHOLD ]; then
    echo "$(date): Large transfer detected - PID: $pid, Bytes Sent: $bytes_sent" >> $LOG_FILE
  fi
done

: << 'COMMENT'

Explanation:

lsof -i: Lists network connections.
/proc/$pid/net/dev: Checks data usage for a specific process.
Purpose: Monitors and logs large file transfers to identify potential data leaks.

