#!/bin/bash

#### Mute microphone
SRC="@DEFAULT_SOURCE@"

#### 1 = MUTE  /  toggle = toggle between states

#### Set mute
#pactl set-source-mute "$SRC" 1 

#### Toggle between states
pactl set-source-mute "$SRC" toggle
