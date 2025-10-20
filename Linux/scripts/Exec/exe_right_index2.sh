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
    
   
    night=$(bash "$HOME/Nextcloud/Linux/scripts/DE_Addon/night_light_check.sh" &)
    uptime=$(bash "$HOME/Nextcloud/Linux/scripts/DE_Addon/uptime.sh" &)
    volume=$(bash "$HOME/Nextcloud/Linux/scripts/Hardware_Info/volume_checker.sh" &)
    ethernet=$(bash "$HOME/Nextcloud/Linux/scripts/DE_Addon/ethernet_check.sh" &)
    micCheck=$(bash "$HOME/Nextcloud/Linux/scripts/Hardware_Info/mic_status.sh" &)
    webcamCheck=$(bash "$HOME/Nextcloud/Linux/scripts/Hardware_Info//webcam_status.sh" &)
    #ps5=$(bash "$HOME/Nextcloud/Linux/scripts/Bluetooth/controller_battery.sh" &)
    #session=$(bash "$HOME/Nextcloud/Linux/scripts/DE_Addon/session_check.sh" &)
    gamemode=$(bash "$HOME/Nextcloud/Linux/scripts/DE_Addon/gamemode_check.sh")

    
    #### re-order (left to right)
    echo -e "$gamemode  $night $uptime $volume  $micCheck$webcamCheck  $ethernet"

    } 2>&1 | tr '\n' ' '
    )



#### Laptop
elif [ "$pc" != "$main" ]; then
    PRINTOUT=$(
    {
    

    night=$(bash "$HOME/Nextcloud/Linux/scripts/DE_Addon/night_light_check.sh" &)
    uptime=$(bash "$HOME/Nextcloud/Linux/scripts/DE_Addon/uptime.sh" &)
    volume=$(bash "$HOME/Nextcloud/Linux/scripts/Hardware_Info/volume_checker.sh" &)
    ethernet=$(bash "$HOME/Nextcloud/Linux/scripts/DE_Addon/ethernet_check.sh" &)
    micCheck=$(bash "$HOME/Nextcloud/Linux/scripts/Hardware_Info/mic_status.sh" &)
    webcamCheck=$(bash "$HOME/Nextcloud/Linux/scripts/Hardware_Info/webcam_status.sh" &)
    
    #ps5=$(bash "$HOME/Nextcloud/Linux/scripts/Bluetooth/controller_battery.sh" &)
    

    #### re-order (left to right)
    echo -e "$night  $uptime  $volume  $micCheck $webcamCheck  $ethernet"
    
    } 2>&1 | tr '\n' ' '
    )
fi





echo "$PRINTOUT"
