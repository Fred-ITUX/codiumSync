#!/bin/bash

#### Mute microphone
SRC="@DEFAULT_SOURCE@"

if [ "$SRC" != "@DEFAULT_SOURCE@" ]; then
   echo -e "error"
   exit 1
fi

#### 1 = MUTE  /  toggle = toggle between states

#### Set mute
pactl set-source-mute "$SRC" 1 

#### Toggle between states
# pactl set-source-mute "$SRC" toggle
