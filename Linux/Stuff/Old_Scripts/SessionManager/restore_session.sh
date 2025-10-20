#!/bin/bash

# Check if a session name is provided
if [[ -z "$1" ]]; then
    echo "Usage: $0 <session_name>"
    exit 1
fi

SESSION_NAME="$1"
SAVE_DIR="$HOME/.sessions"
SAVE_FILE="$SAVE_DIR/$SESSION_NAME"

if [[ ! -f "$SAVE_FILE" ]]; then
    echo "No session file found at $SAVE_FILE"
    exit 1
fi

echo "Restoring session from $SAVE_FILE..."

# Read the session file line by line
while IFS='|' read -r app_name desktop x y width height command; do
    echo "Restoring: $app_name on desktop $desktop"

    # Check if the app is already running
    app_pid=$(xdotool search --class "$app_name" | head -n 1)
    if [[ -z "$app_pid" ]]; then
        echo "Launching $app_name using command: $command"
        $command &
        sleep 3s # Allow some time for the application to launch
    fi

    #### Find the window again after launching or if already running
    app_pid=$(xdotool search --class "$app_name" | head -n 1)
    if [[ -n "$app_pid" ]]; then
        # Restore window position and size
        wmctrl -i -r "$app_pid" -e "0,$x,$y,$width,$height" && echo "Restored geometry for $app_name"
        wmctrl -i -r "$app_pid" -t "$desktop" && echo "Moved $app_name to desktop $desktop"
    else
        echo "Failed to restore $app_name"
    fi



done < "$SAVE_FILE"


# Move the window to a specific position and resize it
xdotool windowmove 0x3c00011 -26 7
xdotool windowsize 0x3c00011 1052 640



echo "Session restored."
