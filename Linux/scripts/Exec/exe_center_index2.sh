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
        
        #### 60s delay 
        weather=$(bash $HOME/Nextcloud/Linux/scripts/DE_Addon/weather.sh)
        
 
    echo -e " $weather"
    } 2>&1 | tr '\n' ' '
    )




#### Laptop
elif [ "$pc" != "$main" ]; then
    PRINTOUT=$(
    {
        

        #### 60s delay 
        weather=$(bash $HOME/Nextcloud/Linux/scripts/DE_Addon/weather.sh)    

    echo -e " $weather"
    } 2>&1 | tr '\n' ' '
    )
fi





echo "$PRINTOUT"
