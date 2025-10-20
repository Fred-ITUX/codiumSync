#!/bin/bash

#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

################################################################################################


userCheck
echo -e ""

#### PC
if [ "$pc" == "$main" ]; then
    PRINTOUT=$(
    {
    
   
    network=$(python3 "$HOME/Nextcloud/Linux/scripts/Hardware_Info/network_usage.py")


    #### re-order (left to right)
    echo -e "$network" 

    } 2>&1 | tr '\n' ' '
    )



#### Laptop
elif [ "$pc" != "$main" ]; then
    PRINTOUT=$(
    {
    
 
    exit 1
    
    #### re-order (left to right)
    #echo -e "$headBattery  $night $uptime $volume $micCheck $webcamCheck $battery $power  $ethernet $session"
    
    } 2>&1 | tr '\n' ' '
    )
fi





echo "$PRINTOUT"
