#!/bin/bash

# pathSource="/sys/class/drm/card1/device/hwmon/hwmon2"
hwPath="$(ls /sys/class/drm/card1/device/hwmon/ | grep "hwmon")"

pathSource="/sys/class/drm/card1/device/hwmon/$hwPath"
