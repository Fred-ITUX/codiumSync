#!/bin/bash

# Configuration
LOG_FILE="/home/federico/Nextcloud/Linux/log/startup_updater.txt"
OLD_LOGS_DIR="/home/federico/Nextcloud/Linux/log/old_startup_logs"
MAX_LINES=2500  # Change this to your preferred maximum line count

# Ensure old logs directory exists
mkdir -p "$OLD_LOGS_DIR"

# Count lines in the log file
LINE_COUNT=$(wc -l < "$LOG_FILE")

# Check if the file exceeds the limit
if [ "$LINE_COUNT" -gt "$MAX_LINES" ]; then
    TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
    NEW_LOG_NAME="$OLD_LOGS_DIR/startup_updater_$TIMESTAMP.txt"
    mv "$LOG_FILE" "$NEW_LOG_NAME"
    touch "$LOG_FILE"
    echo "Log file exceeded $MAX_LINES lines. Moved to: $NEW_LOG_NAME and created a new empty log file."
else
    echo "Log file is within the limit ($LINE_COUNT lines). No action taken."
fi
