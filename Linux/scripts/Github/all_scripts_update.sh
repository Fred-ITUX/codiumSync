#!/bin/bash


#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

path="$HOME/codiumSync/"

read -r -p "Update note: " updateNote

#### default note
if [ "$updateNote" = ""  ]; then
   updateNote="patch update"
fi

readmeText="All folders with scripts to backup"


{

    cp -r $HOME/Nextcloud/Python                "$path"
    cp -r $HOME/Nextcloud/Linux                 "$path"

    echo "$readmeText" > "$path"/README.md

    cd "$path"
    git add .

    #### Print what’s staged
    echo -e "\n • Files staged for commit:"
    git diff --cached --name-only

    echo -e "\n • Committing..."
    git commit -m "$updateNote"

    echo -e "\n • Pulling..."
    git pull origin main

    echo -e "\n • Pushing..."
    git push

    cd
}