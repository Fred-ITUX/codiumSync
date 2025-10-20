#!/bin/bash

# Declare the number of days
days=20

# Declare the path to the directory where the .txt files are stored
log_dir="$HOME/Nextcloud/Linux/log/adv_everyday"

# Get the current date in seconds since the epoch
current_date=$(date +%s)

# Loop through all .txt files in the specified directory
for file in "$log_dir"/*.txt; do
    # Extract the date part from the filename (assuming the format "upd_YYYY-MM-DD_HH-MM-SS")
    file_date=$(echo "$file" | sed -E 's/.*upd_([0-9]{4}-[0-9]{2}-[0-9]{2})_[0-9]{2}-[0-9]{2}-[0-9]{2}.txt/\1/')
    
    # Convert the extracted date to seconds since the epoch
    file_timestamp=$(date -d "$file_date" +%s)
    
    # Calculate the difference in days between the current date and the file's timestamp
    age_in_days=$(( (current_date - file_timestamp) / 86400 ))
    
    # If the file is older than the specified number of days, remove it
    if [ "$age_in_days" -gt "$days" ]; then
        echo "Removing $file (age: $age_in_days days)"
        rm "$file"
    fi
done
