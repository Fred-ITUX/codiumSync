#!/bin/bash

isOn="$(cat $HOME/Nextcloud/Linux/scripts/DE_Addon/night_light_check.txt)"

if [ "$isOn" = "on" ]; then
    #  💡
    echo "🌙"
fi



########################################################

##### Old check

# #### Double check to remove false positives
# hourToCheck=16
# timecheck=$(date +%H)


# # #### for hours before double digit time (07,08,09)
# zeroNumHours="$(echo "$timecheck" | grep "0.")"



# if [ "$zeroNumHours" != '' ]; then
#    exit 0
# fi


# #### if is earlier than hourToCheck echoes "off" -- extra safety step 
# if (( timecheck < hourToCheck )); then
#     echo "off" > $HOME/Nextcloud/Linux/scripts/DE_Addon/night_light_check.txt
# fi
