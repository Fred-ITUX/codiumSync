#!/bin/bash

# Check if a session name is provided
if [[ -z "$1" ]]; then
    echo "Usage: $0 <session_name>"
    exit 1
fi

SESSION_NAME="$1"
SAVE_DIR="$HOME/.sessions"
SAVE_FILE="$SAVE_DIR/$SESSION_NAME"

# Define a mapping of app names to commands
declare -A app_command_map=(
    ["Nemo-desktop"]="nemo"
    ["Gnome-terminal"]="gnome-terminal"
    ["VSCodium"]="codium"
    ["Brave-browser"]="brave-browser"
    ["TelegramDesktop"]="/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=telegram-desktop --file-forwarding org.telegram.desktop -- @@u %u @@"
    ["Whatsapp-for-linux"]="/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=whatsapp-for-linux --file-forwarding com.github.eneshecan.WhatsAppForLinux @@u %u @@"
)

# Ensure the save directory exists
mkdir -p "$SAVE_DIR"

echo "Saving session to $SAVE_FILE"
> "$SAVE_FILE" # Clear previous session data

# Extract window information with wmctrl
wmctrl -lG | while read -r win_id desktop x y width height title; do
    if [[ -n "$win_id" && "$win_id" =~ 0x[0-9a-fA-F]+ ]]; then
        # Extract the application name using xprop
        app_name=$(xprop -id "$win_id" WM_CLASS | awk -F '"' '{print $4}')
        if [[ -n "$app_name" ]]; then
            # Get the command from the app_command_map
            command=${app_command_map[$app_name]}
            if [[ -n "$command" ]]; then
                # Save app name, workspace, geometry, and command
                echo "$app_name|$desktop|$x|$y|$width|$height|$command" >> "$SAVE_FILE"
                echo "Saved: $app_name on desktop $desktop with command $command"
            else
                echo "Skipped: No command mapping for $app_name"
            fi
        else
            echo "Skipped: Unable to identify app for $win_id"
        fi
    fi
done

echo "Session saved."
