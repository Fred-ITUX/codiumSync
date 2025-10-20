#!/bin/bash


#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

#### Sessions app
session_app="$HOME/Nextcloud/Linux/scripts/Sessions/Session_apps.sh"
if [ -f ~/.bash_UT ]; then
    . $session_app
else
    exit 0
fi

################################################

sleep 5s
brave

sleep 20s
nextcloud

sleep 5s
vsCodium

# sleep 10s 
# chrome_full

sleep 30s
steam

pavucontrol &

libreoffice & 

# if [ "$typeDay" == "weekday" ]; then
#     sleep 90s && firefox -new-window &
# fi


