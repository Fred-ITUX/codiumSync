#!/bin/bash


#### 🔥 GPU Fan OFF
echo 1 | sudo tee /sys/class/drm/card1/device/hwmon/hwmon4/pwm1_enable && echo 24 | sudo tee /sys/class/drm/card1/device/hwmon/hwmon4/pwm1

