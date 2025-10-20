#!/bin/bash

#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

################################################################################################


userCheck


#### PC
if [ "$pc" == "$main" ]; then
    PRINTOUT=$(
    {
        
        
    headBattery=$(bash "$HOME/Nextcloud/Linux/scripts/Bluetooth/headset_battery.sh" &)

    echo -e "$headBattery"

    } 2>&1 | tr '\n' ' '
    )



#### Laptop
elif [ "$pc" != "$main" ]; then
    PRINTOUT=$(
    {


    #### network usage ( 4s delay in-script +1 executor)
    network=$(python3 "$HOME/Nextcloud/Linux/scripts/Hardware_Info/network_usage.py" &)

    #ethernet=$(bash "$HOME/Nextcloud/Linux/scripts/DE_Addon/ethernet_check.sh")

    gamemode=$(bash "$HOME/Nextcloud/Linux/scripts/DE_Addon/gamemode_check.sh")

    headBattery=$(bash "$HOME/Nextcloud/Linux/scripts/Bluetooth/headset_battery.sh" &)
    battery=$(bash "$HOME/Nextcloud/Linux/scripts/laptop/battery_check.sh" &)
    power=$(bash "$HOME/Nextcloud/Linux/scripts/laptop/power_mode.sh" &)


    echo -e " $network  $battery  $power  $gamemode  $headBattery"
    
    } 2>&1 | tr '\n' ' '
    )
fi




echo "$PRINTOUT"
