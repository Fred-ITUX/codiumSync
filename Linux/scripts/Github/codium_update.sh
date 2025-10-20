#!/bin/bash


#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

path="$HOME/codiumSync/"

# read -r -p "Update note: " updateNote

# #### default note
# if [ "$updateNote" = ""  ]; then
#    updateNote="patch update"
# fi

updateNote="Automatic patch update"
readmeText="VsCodium extensions & snippets"


{

    #### Snippets & extensions
    cp $HOME/.var/app/com.vscodium.codium/config/VSCodium/User/snippets/*       "$path"
    cp -r $HOME/.var/app/com.vscodium.codium/data/codium                        "$path"


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