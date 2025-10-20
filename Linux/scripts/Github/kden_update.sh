#!/bin/bash


#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

path="$HOME/kdenSync/"

# read -r -p "Update note: " updateNote

# #### default note
# if [ "$updateNote" = ""  ]; then
#    updateNote="patch update"
# fi

updateNote="Automatic patch update"

readmeText="Kdenlive UI settings, configs, documentation and useful scripts for video & audio editing"

{

    #### Snippets & extensions
    cp $HOME/Nextcloud/Kden/scripts/*                                           "$path"

    #### Latex docs
    cp -r $HOME/Nextcloud/Kden/Other/Docs/EditingUtilities                      "$path"

    #### UI layout
    cp -r $HOME/Nextcloud/Kden/Layout                                           "$path"

    #### Config, GUI and settings
    cp -r $HOME/Videos/Edit/Kden/kdenFiles                                      "$path"
    
    #### Remove log file
    rm $path/YT_DLP_update_log.txt

    #### Python scripts
    cp $HOME/Nextcloud/Python/scripts/subtitle.py                               "$path"
    cp $HOME/Nextcloud/Python/scripts/timestamp_merger.py                       "$path"

    cp -r  $HOME/Nextcloud/Python/scripts/TextExtractor                         "$path"
    cp -r  $HOME/Nextcloud/Python/scripts/FileModder                            "$path"

    echo "$readmeText" > "$path"/README.md

    cd "$path"
    git add .

    #### Print what’s staged
    #echo -e "\n • Files staged for commit:"
    #git diff --cached --name-only

    ### git commit -m "updated script"
    echo -e "\n • Committing..."
    git commit -m "$updateNote"

    echo -e "\n • Pulling..."
    git pull origin main

    echo -e "\n • Pushing..."
    git push

    cd
}