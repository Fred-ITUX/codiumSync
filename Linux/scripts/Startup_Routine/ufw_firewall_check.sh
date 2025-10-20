#!/bin/bash

#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

#### firewall check
ufwCheck=$(sudo ufw status | grep "Status: active")


if [ "$ufwCheck" == "" ]; then

    {

    #### log setup - START
    get_sys_Info
    
    echo -e " • UFW status: disabled"
    sudo ufw enable

    ufwCheck=$(sudo ufw status | grep "Status: active")
    echo -e "\nUFW $ufwCheck"

    echo -e "\n • Setting up: reject incoming"
    sudo ufw default reject incoming 

    echo -e "\n • Setting up: allow outgoing" 
    sudo ufw default allow outgoing 
    
    } >> "$ufw_log_check"
fi