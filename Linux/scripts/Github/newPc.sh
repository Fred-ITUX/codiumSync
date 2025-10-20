#!/bin/bash


#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

path="$HOME/newPc_Install/"

read -r -p "Update note: " updateNote

#### default note
if [ "$updateNote" = ""  ]; then
   updateNote="patch update"
fi

{
    #### New_Pc folder
    cp $LXscripts/New_Pc/*                      "$path"

    #### Scripts
    cp -r $LXscripts/bash                       "$path"               
    cp $LXscripts/sys_updater.sh                "$path"

    #### SysInfo folder
    cp -r $LXscripts/sysInfoUT/                 "$path" 


    cd "$path"
    git add .

    #### Print what’s staged
    echo -e "\n • Files staged for commit:"
    git diff --cached --name-only

    ### git commit -m "updated script"
    echo -e "\n • Committing..."
    git commit -m "$updateNote"

    echo -e "\n • Pulling..."
    git pull origin main

    echo -e "\n • Pushing..."
    git push

    cd
}