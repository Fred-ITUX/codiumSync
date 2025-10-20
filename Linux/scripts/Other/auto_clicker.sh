#!/bin/bash


INTERVAL=0                  # Time interval (in seconds) between clicks
BUTTON=1                    # Mouse button: 1 for left, 3 for right
CLICK_TYPE="single"         # "single" or "double" click


while true; do
    if [ "$CLICK_TYPE" = "double" ]; then

        xdotool click "$BUTTON"
        #### A brief pause between clicks for double-click effect; adjust if needed
        sleep 0.1
        xdotool click "$BUTTON"
    
    else
        #### Single click
        xdotool click "$BUTTON"
    fi
    
    sleep "$INTERVAL"
done
