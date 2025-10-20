#!/bin/bash

#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

################################################################################################



userCheck

#### PC
if [ "$pc" == "$main" ]; then
    device=$(nmcli -g DEVICE con | grep "enp")
    type="ethernet"
    
#### Laptop
elif [ "$pc" != "$main" ]; then
    device=$(nmcli -g DEVICE con | grep "wlp1s0")
    type="wifi"
fi


isConnected="$(nmcli con show -a | grep "$device")"

ifVPN="$(nordvpn status | grep "Status: Connected" )"




if [ "$ifVPN" != ''  ]; then
   icon="🌐🔐" #🔒

elif [ "$isConnected" != '' ]; then
    icon="🌐"
   
else
    icon="❌"
fi

echo "$icon"
