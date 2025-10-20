#!/bin/bash


#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

############################################################################

if [ "$sessionType" == "wayland" ]; then

    #### Disable gnome night light
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled false


    ### Reset screen brightness to default values 
    
    ddcutil --display 1 setvcp 10 75            #### HP


    ddcutil --display 2 setvcp 10 75            #### SAMSUNG


else

    # temperature=4200
    # #### 70%
    # brightness=0.7
    ###### clear 
    redshift -m randr -x

fi


#### Check for the top bar icon
echo "off" > $HOME/Nextcloud/Linux/scripts/DE_Addon/night_light_check.txt
