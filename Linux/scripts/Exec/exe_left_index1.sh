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
    
        pcUsage=$(python3 "$HOME/Nextcloud/Linux/scripts/Hardware_Info/pc_usage.py")
        disk=$(python3 "$HOME/Nextcloud/Linux/scripts/Hardware_Info/disk_check.py")
        gpuFanCheck=$(bash "$HOME/Nextcloud/Linux/scripts/Hardware_Info/gpu_fan_speed_check.sh") 

    #### re-order 
    echo -e " $pcUsage $gpuFanCheck $disk"
    } 2>&1 | tr '\n' ' '
    )



#### Laptop
elif [ "$pc" != "$main" ]; then
    PRINTOUT=$(
    {
        

        pcUsage=$(python3 "$HOME/Nextcloud/Linux/scripts/laptop/pc_usage.py")
        disk=$(python3 "$HOME/Nextcloud/Linux/scripts/laptop/disk_check_laptop.py")


    #### re-order
    echo -e " $pcUsage $disk"
    } 2>&1 | tr '\n' ' '
    )
fi





echo "$PRINTOUT"
