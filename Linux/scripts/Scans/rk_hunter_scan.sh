#!/bin/bash

#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

#### prompt avoid
export DEBIAN_FRONTEND=noninteractive


#### log setup - START
get_sys_Info

sudo rkhunter --check --propupd --skip-keypress --no-color -x --report-warnings-only

#### log standard setup end part (end date)
get_sysInfo_END