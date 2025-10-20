#!/bin/bash

outputFile="$HOME/Nextcloud/Python/scripts/UptimePlot/uptime.csv"

uptime_result=$(uptime | cut -d ',' -f 1 | awk '{print $3, $4}')

formattedDate=$(date +"%Y-%m-%d")

#### Night light off
$HOME/Nextcloud/Linux/scripts/Shortcuts/night_light_off.sh

echo "$formattedDate;$uptime_result" >> $outputFile


#### delete bash history
sudo rm $HOME/.bash_history

#### remove kdenlive backups to avoid stacking
sudo rm -rf $HOME/Videos/Edit/Kden/kdenFiles/data/kdenlive/.backup


