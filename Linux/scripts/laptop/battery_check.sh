#!/bin/bash

battery_info=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)

percentage=$(echo "$battery_info" | grep 'percentage:' | awk '{print $2}' | tr -d '% ')


if [ $percentage -le 50 ]; then
    emoji="🪫"
else
    emoji="🔋"
fi

echo "$emoji$percentage%"
