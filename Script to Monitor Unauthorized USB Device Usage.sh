#!/bin/bash

LOG_FILE="/var/log/usb_monitor.log"

udevadm monitor --udev |
while read line; do
  if echo "$line" | grep -q "add"; then
    echo "$(date): Unauthorized USB device detected: $line" >> $LOG_FILE
    # Add additional actions here, e.g., blocking the device.
  fi
done
: << 'COMMENT'

Explanation:

udevadm monitor: Tracks hardware events (e.g., USB connections).
Purpose: Detects and logs unauthorized USB devices to prevent data exfiltration via removable drives.
