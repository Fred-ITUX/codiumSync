#!/bin/bash

#### 🌬️ GPU Fan Speed 75%
GPUsourceFile="$HOME/Nextcloud/Linux/scripts/Shortcuts/GPU_fan_speed/gpu_fan_speed_source.sh"
if [ -f  ]; then
   . "$GPUsourceFile"
fi

echo 1 | sudo tee $pathSource/pwm1_enable && echo 193 | sudo tee $pathSource/pwm1