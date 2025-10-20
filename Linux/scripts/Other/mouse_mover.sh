#!/bin/bash




#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

############################################################################

#### X11 only
if [ "$sessionType" == "wayland" ]; then
    echo -e "X11 only"
    exit 0
fi


while :; do 
    xdotool mousemove_relative -- $(( $RANDOM % 3 - 1 )) $(( $RANDOM % 3 - 1 )) sleep 1; 
done