#!/bin/bash

# for file in "$@"; do
#     info=$(mediainfo "$file" | grep -E "Width|Height|Frame rate  |Duration|File size" | awk '!seen[$1, $2]++')
#     echo -e "File: $file\n$info"
# done | zenity --text-info --width=500 --height=300 --title="Video Info"




for file in "$@"; do
    echo "File: $file"
    
    mediainfo "$file" | grep -E "Width|Height|Frame rate  |Overall bit rate|Duration|File size" | awk '!seen[$1, $2]++' |  
    awk -F ': ' '{
        value = $2;
        gsub(/^[ \t]+|[ \t]+$/, "", value);                     
        
        if ($1 ~ /File size/)       print "Size:\t\t" value;
        else if ($1 ~ /Duration/)   print "Length:\t\t" value;
        else if ($1 ~ /Frame rate/) print "FPS:\t\t" value;
        else if ($1 ~ /Width/)      print "Width:\t\t" value;
        else if ($1 ~ /Height/)     print "Height:\t\t" value;
        else if ($1 ~ /Overall bit rate/)     print "Bit rate:\t\t" value;
    } ' 
done | zenity --text-info --width=500 --height=300 --title="Video Info"
