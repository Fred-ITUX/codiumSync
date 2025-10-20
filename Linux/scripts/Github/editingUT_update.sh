#!/bin/bash


#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi


# read -r -p "Update note: " updateNote

# #### default note
# if [ "$updateNote" = ""  ]; then
#    updateNote="patch update"
# fi


path="$HOME/editingUT/"

updateNote="Automatic patch update"

readmeText="Editing utilities"



#### Check for differences withouth having to cp -r everytime the folders
DIFF_editingUT="$(diff -qr "$path"/EditingUT $HOME/Nextcloud/Kden/EditingUT )"
DIFF_muisc="$(diff -qr "$path"/MusicForEditing $HOME/Nextcloud/Kden/MusicForEditing )"
DIFF_other="$(diff -qr "$path"/Other $HOME/Nextcloud/Kden/Other )"

#### If there are some differencies then update the repo
diff="$DIFF_editingUT$DIFF_muisc$DIFF_other"

if [ "$diff" != "" ]; then

    cp -r $HOME/Nextcloud/Kden/EditingUT                                    "$path"
    cp -r $HOME/Nextcloud/Kden/MusicForEditing                              "$path"
    cp -r $HOME/Nextcloud/Kden/Other                                        "$path"

    #### another window session manager editing session
    cp $HOME/.config/another-window-session-manager/sessions/Editing        "$path"

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

else 
    echo -e "No changes to commit"

fi