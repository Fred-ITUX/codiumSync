#!/bin/bash


#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

############################################################################

if [ "$sessionType" = "wayland" ]; then

    temperature=3500
    brightness=30

    ddcutil --display 1 setvcp 10 "$brightness"        #### HP
    ddcutil --display 2 setvcp 10 "$brightness"        #### SAMSUNG

    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
    sleep 2s
    gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature "$temperature"

else

    #### X11
    #### 60%
    brightness=0.7
    temperature=3800

    ###### clear previous
    redshift -m randr -x

    ###### setup 
    redshift -m randr -O $temperature -b $brightness

fi



#### Check for the top bar icon
echo "on" > $HOME/Nextcloud/Linux/scripts/DE_Addon/night_light_check.txt






