#!/bin/bash

GPUsourceFile="$HOME/Nextcloud/Linux/scripts/Shortcuts/GPU_fan_speed/gpu_fan_speed_source.sh"
if [ -f  ]; then
   . "$GPUsourceFile"
fi

#### Read the current mode
fanMode=$(cat $pathSource/pwm1_enable)

#### Read the current speed
fanSpeed=$(cat $pathSource/pwm1)

#### Calculate fan speed average
fanSpeedPercent=$(( fanSpeed * 100 / 255 ))


if [ "$fanMode" = "2" ]; then
   fanMode="🤖"

elif [ "$fanMode" = "1" ]; then
    fanMode="🖐🏻" #🎛️
    
else
    echo -e "⚠️ ERROR ⚠️"
    exit 1
fi

echo -e "$fanMode🌀$fanSpeedPercent%"