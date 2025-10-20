#!/bin/bash

#########################################################################
#### Aliases definition
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#### Functions definition
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

declare -A pid_names

userCheck
#########################################################################



#########################################################################
gSettingsSetup(){
    gsettings set org.gnome.desktop.interface enable-animations false
}
sleep 5s && gSettingsSetup &
sleep 35s && gSettingsSetup &



adv_log_check(){
    cd $HOME/Nextcloud/Linux/log/adv_everyday
    latest=$(ls -t | head -n 1)

    latest_check=$(cat "$latest" | grep -i "error" )

    if [ "$latest_check" == "" ]; then
        :
    else 
        vlc "$logCheckerAlarm"  #### --gain=3
        gedit "$latest" &
fi
}



startupSystemUpdater(){

    strtp_upd_full="$pathStartupUpdaterFull"

    touch "$strtp_upd_full"

    $LXscripts/sys_updater.sh | tee -a "$pathStartupUpdaterClean" "$strtp_upd_full" 2>&1

    python3 $LXscripts/Startup_Routine/log_cleaner.py 

    adv_log_check 

    $LXscripts/Startup_Routine/old_logs_remover.sh

    $LXscripts/Startup_Routine/old_startup_log_remover.sh

    gnome-text-editor &
} 



#########################################################################





#########################################################################
if [ "$pc" == "$main" ]; then

    sleep 5s && "$LXscripts"/Shortcuts/internet_refresh.sh &
    pid_names["Ethernet & VPN"]=$!

    sudo mount /dev/sda1 /media/federico/SSD450GB/
    sudo mount /dev/sdb /media/federico/SSD1TB/
    sudo mount /dev/sdc1 /media/federico/HDD2TB/

    $LXscripts/Shortcuts/GPU_fan_speed/gpu_fan_speed_50.sh     #### 35 - 50 - 75 - 100
    
    $repo_kdenUPD &
    pid_names["Kden repo auto update"]=$!

    pid_log_file="$LXscripts/Startup_Routine/pids.txt"
    startupSystemUpdaterDelay=5
    sleep "$startupSystemUpdaterDelay"m && startupSystemUpdater &
    pid_names["System updater ~ delay "$startupSystemUpdaterDelay"m"]=$!


#### Laptop
elif [ "$pc" != "$main" ]; then

    sleep 30s 
    nordvpn connect italy &
    pid_names["VPN"]=$!
    sleep 3m

    $LXscripts/Sessions/Session_re-run.sh &

    pid_log_file="$LXscripts/Startup_Routine/pids_laptop.txt"
    
    startupSystemUpdaterDelay=8
    sleep "$startupSystemUpdaterDelay"m && startupSystemUpdater &
    pid_names["System updater ~ delay "$startupSystemUpdaterDelay"m"]=$!
    echo -e " \n ⚠️ Quick exit: $(get_formatted_date)\n" > "$pid_log_file"
    for name in "${!pid_names[@]}"; do
        echo -e "${pid_names[$name]} — $name" >> "$pid_log_file"
    done
    exit 0

fi
#########################################################################





#########################################################################
#### In case of session swap avoid launching everything again
isFirstRoutine=$(cat "$pid_log_file" | grep "$(get_date_comparison)")

if [ "$isFirstRoutine" != ""  ]; then
    $LXscripts/Sessions/Session_re-run.sh &
    echo -e "\n ⚠️ Re-run avoided: $(get_formatted_date)" >> "$pid_log_file"
    exit 0
fi
#########################################################################





#########################################################################
####                        APPS & SCRIPTS

$LXscripts/Shortcuts/night_light_off.sh
pid_names["Night light off"]=$!


python3 $PYscripts/UptimePlot/uptime_check.py &
pid_names["Uptime plots"]=$!


$LXscripts/Startup_Routine/ufw_firewall_check.sh &
pid_names["UFW check"]=$!


$LXscripts/Shortcuts/microphone_mute.sh &
pid_names["Mic mute"]=$!


$LXscripts/Sessions/Session_startup.sh &
pid_names["Session startup"]=$!


$LXscripts/Github/codium_update.sh & 
pid_names["Codium repo update"]=$!

$LXscripts/Github/editingUT_update.sh &
pid_names["EditingUT repo update"]=$!



vscanDelay=7
pathToScan="$HOME/Nextcloud"
sleep "$vscanDelay"m && vscan "$pathToScan" &
pid_names["Vscan ("$pathToScan") ~ delay "$vscanDelay"m"]=$!

#########################################################################





#########################################################################
####                            PIDs logging
{
    echo -e "\nStartup routine PIDs -- "$(get_formatted_date)"
    Running for:  $(whoami)@$osname [$(hostname)]\n" 

    for name in "${!pid_names[@]}"; do
        echo -e "${pid_names[$name]} — $name"
    done

} > "$pid_log_file"
#########################################################################


