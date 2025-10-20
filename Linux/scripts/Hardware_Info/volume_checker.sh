#!/bin/bash

#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

################################################################################################ 


#### Get active sink
activeSink="$(pactl get-default-sink)"

#### Bluetooth headset
bluetoothSink=$(echo -e "$activeSink" | grep "bluez")
bltProfile="a2dp-sink-sbc_xq"

#### Jack sink
stereoSink=$(echo -e "$activeSink" | grep "analog-stereo")



if [ "$activeSink" == "$bluetoothSink" ]; then

    vol="$(pactl get-sink-volume "$bluetoothSink" | grep '%' |  awk '{print $5}' | tr -d '%')"

    #### Check for profile swap
    bluezCard=$(pactl list sinks | grep -i bluez_card | awk -F'= '  '{print $2}' | tr -d '"' )
    
    #### If the profile does not exist, refresh connection
    checkProfile=$(pactl list | grep -i "$bltProfile")
    if [ "$checkProfile" == '' ]; then
      $LXscripts/Shortcuts/headset_connect.sh > /dev/null 
    fi

    switchProfile=$(pactl set-card-profile "$bluezCard" "$bltProfile")


elif [ "$activeSink" ==  "$stereoSink" ]; then

    vol="$(pactl get-sink-volume "$stereoSink" | grep '%' |  awk '{print $5}' | tr -d '%')"


else
    #### Default to 0 if no sink are active
    # vol="${vol:-0}"
    vol=0
fi


if [ "$vol" -eq 0 ]; then
    icon="🔇"
    echo -e "$icon"

elif [ "$vol" -le 35 ]; then
    icon="🔉"  
    echo -e "$icon$vol%"

else
    icon="🔊" 
    echo -e "$icon$vol%"
fi



