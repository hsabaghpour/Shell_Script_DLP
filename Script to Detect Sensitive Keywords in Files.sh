#!/bin/bash

SEARCH_DIR="/sensitive_data"
KEYWORDS=("password" "confidential" "SSN")
LOG_FILE="/var/log/keyword_detection.log"

for file in $(find $SEARCH_DIR -type f); do
  for keyword in "${KEYWORDS[@]}"; do
    if grep -qi "$keyword" "$file"; then
      echo "$(date): Found '$keyword' in file '$file'" >> $LOG_FILE
    fi
  done
done
: << 'COMMENT'
Explanation:

find: Searches for all files in the directory.
grep -qi: Searches for keywords (case-insensitive) within files.
Purpose: Identifies files containing sensitive information to prevent data leaks.
