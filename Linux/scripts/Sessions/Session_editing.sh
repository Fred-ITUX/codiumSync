#!/bin/bash


#### No output in the terminal
export FLATPAK_LOG_LEVEL=0


echo -e "\n    • Audacity"
flatpak run org.audacityteam.Audacity 2>/dev/null &
sleep 5s


echo -e "\n    • Brave incognito"
flatpak run com.brave.Browser --incognito https://www.youtube.com/feed/subscriptions https://www.remove.bg/upload https://notube.link/it/youtube-app-211 https://www.google.com/imghp?hl=it&ogbl 2>/dev/null &
sleep 10s



echo -e "\n    • GIMP"
flatpak run org.gimp.GIMP 2>/dev/null &
sleep 5s



echo -e "\n    • OBS"
flatpak run com.obsproject.Studio 2>/dev/null &
sleep 5s


echo -e "\n    • Text editors"
gnome-text-editor 2>/dev/null &
gedit $HOME/Nextcloud/Kden/DaFixare.txt $HOME/Nextcloud/Kden/Other/Docs/MusicInfo.txt &


echo -e "\n    • Nemo"
nemo --tabs $HOME/Downloads/ $HOME/Videos/Edit/Projects/ $HOME/Videos/Edit/ $HOME/Videos/ &> /dev/null &
nemo --tabs $HOME/Downloads/ $HOME/Videos/Edit/Projects/ $HOME/Videos/Edit/ $HOME/Videos/ &> /dev/null &


echo -e "\n    • Pavucontrol"
pavucontrol 2>/dev/null &


echo -e "\n    • Terminal"
cd $HOME
gnome-terminal &
gnome-terminal &

