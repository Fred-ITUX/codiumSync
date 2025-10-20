#!/bin/bash

GPUsourceFile="$HOME/Nextcloud/Linux/scripts/Shortcuts/GPU_fan_speed/gpu_fan_speed_source.sh"
if [ -f  ]; then
   . "$GPUsourceFile"
fi

#### 🍃 GPU Fan Speed (30% 80)
echo 1 | sudo tee $pathSource/pwm1_enable && echo 92 | sudo tee $pathSource/pwm1
