#!/bin/bash


#### The default source
SRC="@DEFAULT_SOURCE@"


#### Get volume (e.g. “50%”)
VOL=$(pactl get-source-volume "$SRC" \
       | awk '/Volume:/ { print $5; exit }')


#### Get mute state (yes/no)
MUTED=$(pactl get-source-mute "$SRC" \
        | awk '/Mute:/ { print $2 }')



if [ "$MUTED" == "no" ]; then
        echo "🎙️ $VOL"
else
        #echo "Microphone is muted: $MUTED"
        echo -e "🎙️🚫"
        #:
fi



#### 🎤🎙️