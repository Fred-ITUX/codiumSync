#!/bin/bash


device="Microdia JOYACCESS"

isConnected=$(lsusb | grep -i "$device")

if [ "$isConnected" != ""  ]; then
    status=$(lsof /dev/video0)
else
    exit 0
fi




#### Is active
if [ "$status" != ""  ]; then
    #### 📷   📸   🎥   📹   🎦
   echo -e "📸"
fi
