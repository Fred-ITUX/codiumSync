#!/bin/bash

start_time=$(date '+%d-%m-%Y___%H-%M-%S')

StartDiskSpace=$(df -h)

pathFile="$HOME/newPC_$start_time.txt"

SWAP=8
SWAPPINESS=80
CACHE_PRESSURE=60

safetyUpdateCheck(){
sudo dpkg --configure -a 
sudo apt --fix-broken install -y  
sudo apt update
sudo apt full-upgrade -y 
sudo apt autoremove -y 
sudo apt clean
}



####################################################################


echo -e "\n\n
    +--------------------------+ 

            REQUIREMENTS

    +--------------------------+

    > "$SWAP"GB swap memory will be created
    > The pc will automatically reboot at the end \n\n\n
"
read -r -p "Press Enter to continue..."
echo -e "Continuing..."


echo -e "Background flatpak (flathub) install \n"
sudo apt install flatpak -y 
flatpak install flathub -y 

sudo apt install python3-full -y




echo -e "\n\n\n\n\n
+------------------------------------+ 

        START INSTALL SCANNERS

+------------------------------------+\n\n\n\n\n"

echo -e "\n\n\n\n  Clamav:"
# clamav - antivirus and DB create-update
sudo apt install clamav clamav-daemon clamav-freshclam -y
clamconf
sudo freshclam
echo -e "\n\n\n\n  Rk hunter:"
# rkhunter - rootkit
sudo apt install rkhunter -y
echo -e "\n\n\n\n\n
+------------------------------------+ 

        END   INSTALL SCANNERS

+------------------------------------+\n\n\n\n\n"



########################################################################################################
########################################################################################################
########################################################################################################


touch "$pathFile"

echo -e "\n\nFrom now on is automatic\n Continuing with the script...\n\n\tCheck log: $pathFile "



#### prompt avoid
export DEBIAN_FRONTEND=noninteractive


{

echo -e "

        +------------------------+ 

                CODE START

        +------------------------+

"




echo -e "\n\n\n
+-----------------------------------------------------------+ 

        START UPDATE, FULL UPGRADE AND CHECK INSTALLS

+-----------------------------------------------------------+\n\n\n"
safetyUpdateCheck
echo -e "\n\n\n
+---------------------------------------------------------+ 

        END UPDATE, FULL UPGRADE AND CHECK INSTALLS

+---------------------------------------------------------+\n\n\n"


########################################################################################################
########################################################################################################
########################################################################################################




echo -e "\n\n\n\n\n
        +------------------------------------------+ 

                REPOSITORY && APT APPS BEGIN

        +------------------------------------------+\n\n\n\n\n"




echo -e "\n\n\n\n\n
+----------------------------------------+ 

        START INSTALL PC UTILITIES

+----------------------------------------+\n\n\n\n\n"


pcUtilitiesPackages=(
        #### Github & gh
        wget 
        curl 
        git 
        gh                                      #### github session login
        gufw                                    #### firewall
        htop                                    #### task manager
        playerctl                               #### media player control
        fzf                                     #### terminal interactive selection
        nemo                                    #### file explorer
        rar
        #### Pulseaudio
        pulseaudio
        pavucontrol 
        pulseaudio-module-bluetooth 
        bluez 
        bluez-tools
        font-manager
)

printf '%s\n\n' "${pcUtilitiesPackages[@]}" \
  | xargs -I{} bash -c 'echo -e "\n\n\n\t• Installing: {}" && sudo apt install -y "{}"' \
>> "$pathFile" 2>&1

echo -e "\n\n\n\n\n
+----------------------------------------+ 

        END   INSTALL PC UTILITIES

+----------------------------------------+\n\n\n\n\n"




#### apps, utilities, checkers, AMD GPU info & additional libraries for compatibility...
sudo apt install gamemode zram-tools cpufrequtils radeontop lib32gcc-s1 lib32stdc++6 libvulkan1 libvulkan1:i386 libx11-6:i386 libxext6:i386 libxrandr2:i386 libxrender1:i386 libxslt1.1:i386 libfreetype6:i386 libpng16-16:i386 libz1:i386 libsdl2-2.0-0 libsdl2-2.0-0:i386 vainfo libva-glx2 libva-glx2:i386 libva2 libva2:i386  libcurl4-openssl-dev libxrandr-dev libxinerama-dev libudev-dev libpci3 mesa* ffmpeg* melt frei0r-plugins ladspa-sdk sox gstreamer1.0-libav libx264-dev libx265-dev libvpx-dev libmp3lame0 handbrake mediainfo nomacs libmlt-data liba52-0.7.4 libfaac-dev libopus-dev libvorbis-dev libflac-dev libtheora-dev libquicktime2 libswscale-dev libpostproc-dev libavfilter-dev libbluray-dev libdvdread8 libdvdnav4 libopenexr-dev libpng-dev libjpeg-dev kdenlive-data gpac v4l-utils libx264-dev libx265-dev gmic libdvdnav-dev libdvdread-dev libv4l-0 libx11-6 libxext6 libpulse0 libomxil-bellagio0 libjack-jackd2-0 libsdl2-2.0-0 libfaad2 libglib2.0-0 libxrender1 libjpeg-turbo8 libgegl-dev libheif1 libjpeg-turbo8 libgegl-dev libheif1 libtiff-tools libtiff-dev libpng-dev libwebp-dev colord icc-profiles argyll imagemagick exiv2 libexif-dev pngquant libopenjp2-7 vlc gedit -y 





echo -e "\n\n\n\n\n
        +----------------------------------------+ 

                REPOSITORY && APT APPS END

        +----------------------------------------+\n\n\n\n\n"





########################################################################################################
########################################################################################################
########################################################################################################


echo -e "\n\n\n\n\n
+-----------------------------------+ 

        START SWAP ALLOCATION

+-----------------------------------+\n\n\n"

sudo swapon --show
free -h
df -h
sudo fallocate -l "$SWAP"G /swapspace
ls -lh /swapspace
sudo chmod 700 /swapspace
ls -lh /swapspace
sudo mkswap /swapspace
sudo swapon /swapspace
sudo swapon --show
free -h
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapspace none swap sw 0 0' | sudo tee -a /etc/fstab
cat /proc/sys/vm/swappiness


sudo sysctl vm.swappiness="$SWAPPINESS"
echo -e "vm.swappiness=$SWAPPINESS" | sudo tee -a /etc/sysctl.conf   
echo "$"$SWAPPINESS"" | sudo tee /proc/sys/vm/swappiness


sudo sysctl vm.vfs_cache_pressure="$CACHE_PRESSURE"
echo "$CACHE_PRESSURE" | sudo tee /proc/sys/vm/vfs_cache_pressure
echo -e "vm.vfs_cache_pressure=$CACHE_PRESSURE" | sudo tee -a /etc/sysctl.conf



swapCheck=$(sudo swapon --show)
echo -e "Swap check: $swapCheck"

echo -e "\n\n\n
+---------------------------------+ 

        END SWAP ALLOCATION

+---------------------------------+\n\n\n\n\n"


########################################################################################################
########################################################################################################
########################################################################################################

echo -e "\n\n\n\n\n
        +--------------------------------+ 

                FLATPAK APPS BEGIN

        +--------------------------------+\n\n\n\n\n"

flatpakAppPackages=(
    com.brave.Browser
    app/com.google.Chrome/x86_64/stable
    org.torproject.torbrowser-launcher
    app/com.vscodium.codium/x86_64/stable                       #### VS Codium
    app/com.usebottles.bottles/x86_64/stable                    #### Bottles - WINE client
    com.ktechpit.orion                                          #### torrent
    com.transmissionbt.Transmission                             #### bit torrent
)


printf '%s\n\n' "${flatpakAppPackages[@]}" \
  | xargs -I{} bash -c 'echo -e "\n\n\n\t• Installing {}..." && flatpak install -y "{}"' \
>> "$pathFile" 2>&1



echo -e "\n\n\n\n\n
            +------------------------------+ 

                    FLATPAK APPS END

            +------------------------------+\n\n\n\n\n"


########################################################################################################
########################################################################################################
########################################################################################################


echo -e "\n\n\n\n\n
            +--------------------------------------------+ 

                    START PRE-INSTALLED APPS PURGE

            +--------------------------------------------+\n\n\n\n\n"

appToPurge=(
        #### Mint / Ubuntu apps
        thunderbird* 
        cheese 
        hypnotix 
        rhythmbox 
        aisleriot 
        celluloid  
        hexchat 
        onboard 
        mahjongg 
        pix 
        remmina 
        five-or-more 
        four-in-a-row 
        drawing 
        xed 
        lightsoff 
        hitori 
        quadrapassel 
        shotwell 
        swell-foop 
        tali 
        evolution 
        evince 
        iagno 
        warpinator
        mintchat
        baobab
        #### Gnome apps
        gnome-mahjongg 
        gnome-mines 
        gnome-sudoku 
        gnome-todo 
        gnome-chess 
        gnome-2048 
        gnome-contacts 
        gnome-maps 
        gnome-tetravex 
        gnome-music 
        gnome-nibbles 
        gnome-klotski 
        gnome-robots 
        gnome-weather 
        gnome-remote-desktop 
        gnome-taquin 
)

printf '%s\n' "${appToPurge[@]}" \
  | xargs -I{} bash -c 'echo -e "\n\n\n\t• Uninstalling {}..." && sudo apt purge -y "{}"' \
>> "$pathFile" 2>&1

#### Cinammon DE remover
# sudo apt purge cinnamon* -y
sudo apt purge mintwelcome -y

#### Re-install nemo (it gets removed from the DE remover)
sudo apt install nemo -y


echo -e "\n\n\n\n\n
            +------------------------------------------+ 

                    END PRE-INSTALLED APPS PURGE

            +------------------------------------------+\n\n\n\n\n"




###############################################################

##########        DON'T ADD CODE AFTER THIS          ##########

###############################################################


echo -e "\n\n\n\n\n
+------------------------------------------------------------+ 

        START FINAL UPDATE, UPGRADE, CHECKS && CLEANUP

+------------------------------------------------------------+\n\n\n\n\n"
safetyUpdateCheck
echo -e "\n\n\n\n\n
+----------------------------------------------------------+ 

        END FINAL UPDATE, UPGRADE, CHECKS && CLEANUP

+----------------------------------------------------------+\n\n\n\n\n"





echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n
            +----------------------+ 

                    END CODE

            +----------------------+\n\n\n"


########################################################################################################
########################################################################################################
########################################################################################################


#### log
end_time=$(date '+%d-%m-%Y___%H:%M:%S')

EndDiskSpace=$(df -h)


echo -e "\n\n
                +------------------+ 

                        INFO

                +------------------+\n\n"

echo -e "Start time:\t$start_time"
echo -e "End time  :\t$end_time"

echo -e "\n\nStart disk space:\t$StartDiskSpace"
echo -e "End disk space      :\t$EndDiskSpace \n\n"


} >> "$pathFile" 2>&1 


flatpak override --user --device=dri com.google.Chrome
flatpak override --user --device=dri com.brave.Browser

#### firewall setup check
sudo ufw default reject incoming 
sudo ufw default allow outgoing 

#### Remove useless Ubuntu sessions options from login
sudo rm /usr/share/xsessions/ubuntu*.desktop
sudo rm /usr/share/wayland-sessions/ubuntu*.desktop


reboot 

