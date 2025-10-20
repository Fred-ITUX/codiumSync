#!/bin/bash

#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

################################################################################################ 

####                                                                            remove the (               substitues ) with void
#controllerBattery=$(bluetoothctl info "$ps5Controller" | grep "Battery Percentage: " | awk -F'(' '{print $2}' | sed 's/)//' )

controllerBattery=$(bluetoothctl info "$ps5Controller" | grep "Battery Percentage: " | awk -F'(' '{print $2}' | sed 's/)//' )

if [ "$controllerBattery" == "" ]; then
   exit 0
fi

echo -e "🎮 $controllerBattery%"







################################################################################################ 
################################################################################################ 
################################################################################################ 


# import subprocess
# import re
# import time

# def get_ps5_controller_battery():
#     try:
#         # List all UPower devices
#         upower_devices = subprocess.check_output(['upower', '-e'], text=True).splitlines()
        
#         # Look for a device path containing "ps_controller_battery"
#         ps5_device_path = None
#         for device in upower_devices:
#             if 'ps_controller_battery' in device.lower():
#                 ps5_device_path = device
#                 break
        
#         if not ps5_device_path:
#             print("")
#             return
        
#         # Get details of the PS5 controller device
#         device_info = subprocess.check_output(['upower', '-i', ps5_device_path], text=True)
        
#         # Extract battery percentage using a regex
#         match = re.search(r'percentage:\s+(\d+)%', device_info)
#         if match:
#             battery_level = int(match.group(1))
#             print(f"🎮 {battery_level}%")
#         else:
#             print("")

#     except Exception as e:
#         print("")


# if __name__ == "__main__":
#     get_ps5_controller_battery()
