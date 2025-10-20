#!/bin/bash


#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

#### Phone scripts for iSH
#### git clone https://github.com/Fred-ITUX/phoneScripts.git

path="$HOME/phoneScripts/"

originPath="$HOME/Nextcloud/PhoneScripts"

read -r -p "Update note: " updateNote

#### default note
if [ "$updateNote" = ""  ]; then
   updateNote="patch update"
fi

{
    #### Python scripts
    cp $PYscripts/measure_unit_converter.py         "$path/Scripts/"
    cp $PYscripts/passwd_gen.py                     "$path/Scripts/"
    cp $PYscripts/perc_calc.py                      "$path/Scripts/"
    cp $PYscripts/randomChoose.py                   "$path/Scripts/"

    cp $PYscripts/Style/tableStyle.py               "$path/Scripts/"

    cp -r $PYscripts/Games                          "$path/Scripts/"

    #### Linux scripts
    cp $LXscripts/DE_Addon/weather.sh               "$path/Scripts/"


    #### Phone stuff
    cp $originPath/README.md                        "$path"

    cp $originPath/loop.sh                          "$path/Utilities/"
    cp $originPath/new_install.sh                   "$path/Utilities/"
    cp $originPath/profile.sh                       "$path/Utilities/"
    cp $originPath/repo_update.sh                   "$path/Utilities/" 
    cp $originPath/startup_routine.sh               "$path/Utilities/"
    cp $originPath/setup.sh                         "$path/Utilities/"
    cp $originPath/welcome_home.sh                  "$path/Utilities/"




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