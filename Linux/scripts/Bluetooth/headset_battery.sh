#!/bin/bash

#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

################################################################################################ 

getActiveDevice  "$bletoothInEar" "$bluetoothHeadset"


####                                                                            remove the (               substitues ) with void
headsetBattery=$(bluetoothctl info "$activeDevice" | grep "Battery Percentage: " | awk -F'(' '{print $2}' | sed 's/)//' )

if [ "$headsetBattery" == "" ]; then
   exit 0
fi

echo -e "🎧 $headsetBattery%"




# #### Set the active device on demand
# getActiveDevice(){

#     for device in "$@"; do

#         notActive=$(bluetoothctl info "$device" | grep -i "Connected: no")

#         if [ "$notActive" == ""  ]; then
#             activeDevice="$device"
#         fi
#     done
# }





################################################################################################ 
################################################################################################ 
################################################################################################ 

#### Python version

# import subprocess
# import re  



# #### WH-CH720N - Sony headset
# sonyHeadset='00:A4:1C:04:E1:1F'


# ##################################################################

# def get_battery(mac_address):
#     try:
#         # Run 'bluetoothctl' to show information for the device
#         output = subprocess.check_output(f"bluetoothctl info {mac_address}", shell=True).decode()
        
#         # Extract the battery percentage using regex
#         battery_level = re.search(r'Battery Percentage:\s+0x[0-9a-fA-F]+\s+\((\d+)\)', output)


#         if battery_level:
#             return f"{battery_level.group(1)}"

            
#     except subprocess.CalledProcessError as e:
#         return None


# ##################################################################


# sonyHeadsetBattery = get_battery(sonyHeadset)
# if sonyHeadsetBattery:
#     print(f"🎧 {sonyHeadsetBattery}%")


