#!/bin/bash

#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

################################################################################################ 


bluetoothctl disconnect "$bletoothInEar"
bluetoothctl disconnect "$bluetoothHeadset"



#### bluetoothctl connect "$bletoothInEar" 
#### bluetoothctl connect "$bluetoothHeadset"

