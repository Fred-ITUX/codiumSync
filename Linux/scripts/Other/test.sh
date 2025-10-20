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

#########################################################################

# flatpak install app/com.ktechpit.orion/x86_64/stable -y
# flatpak run com.ktechpit.orion/x86_64/stable &


# flatpak uninstall app/com.ktechpit.orion/x86_64/stable -y
# rm -rf /home/federico/.var/app/com.ktechpit.orion
# rm /home/federico/Downloads/.Orion.id
# rm -rf /home/federico/Downloads/Orion



