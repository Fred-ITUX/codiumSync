#!/bin/bash

sessionType="$XDG_SESSION_TYPE"


if [ "$sessionType" = "wayland" ]; then

    session="WAY"

elif [ "$sessionType" = "x11"  ]; then

   session="X11"

else
    exit 1
fi

echo -e "$session"