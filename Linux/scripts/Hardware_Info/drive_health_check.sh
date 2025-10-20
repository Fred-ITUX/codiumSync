#!/bin/bash

#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi


checkTestStatus() {
    for disk in "$@"; do
        echo -e "\n• Starting checks for \n   $disk at "$(get_formatted_date)""
        exit
        while true; do
            if [[ "$disk" == *nvme* ]]; then
                in_progress=$(sudo smartctl -d nvme -a "$disk" | grep -i "Progress")
                [[ -n "$in_progress" ]] || break
            else
                sudo smartctl -a "$disk" | grep -qi "Self-test routine in progress" || break
            fi

            echo -e "\t$disk: still running..."
            sleep 1m

        done

        echo -e "\t$disk: test finished.\n"
    done
}




#### Keep it short unlsess suspecting failing and / or bad partitions
#### AVG time -> short ~3m --- long hours+ 
testType="short" #### long



#### PC
if [ "$(hostname)" = "federico" ]; then

    path="$HOME/Nextcloud/PcHealth/Disks/pc/"$(get_file_date)""

    mkdir -p "$path"


    ####            Info & health check
    
    ssd1="/dev/sda"
    ssd2="/dev/sdb"
    hdd2tb="/dev/sdc1"
    nvme="/dev/nvme0n1"
    
    ssdLog1="$path/ssd1_check.txt"
    ssdLog2="$path/ssd2_check.txt"
    hdd2tb_log="$path/hdd2tb_check.txt"
    
    nvmeLog="$path/nvme_check.txt"



    sudo smartctl --all "$ssd1" | tee "$ssdLog1"

    sudo smartctl --all "$ssd2" | tee "$ssdLog2"

    sudo smartctl --all "$hdd2tb" | tee "$hdd2tb_log"

    sudo smartctl -d nvme --all "$nvme" | tee "$nvmeLog"



    ####            Test disks & partitions

    echo -e "Launching $testType tests for:\n •$ssd1\n •$ssd2\n •$nvme"

    sudo smartctl --test="$testType" "$ssd1"
    sudo smartctl --test="$testType" "$ssd2"
    sudo smartctl --test="$testType" "$hdd2tb"
    sudo smartctl -d nvme --test="$testType" "$nvme"


    ####            Check test progress & wait till finishes to write logs
    checkTestStatus "$ssd1" "$ssd2" "$hdd2tb" "$nvme"

    ssd1TestLog="$path/ssd1_selftest.txt"
    ssd2TestLog="$path/ssd2_selftest.txt"
    hdd2tbTestLog="$path/hdd2tb_selftest.txt"
    nvmeTestLog="$path/nvme_selftest.txt"


    ####            Log once the tests are completed
    echo -e "\n\nWriting log files:\n• $ssd1TestLog\n• $ssd2TestLog\n• $hdd2tbTestLog\n• $nvmeTestLog\n"

    sudo smartctl -a "$ssd1" | grep -A10 "Self-test" > "$ssd1TestLog"
    sudo smartctl -a "$ssd2" | grep -A10 "Self-test" > "$ssd2TestLog"
    sudo smartctl -a "$hdd2tb" | grep -A10 "Self-test" > "$hdd2tbTestLog"
    sudo smartctl -d nvme -a "$nvme" | grep -A10 "Self-test" > "$nvmeTestLog"


fi









#### Laptop
if [ "$(hostname)" != "federico" ]; then

    path="$HOME/Nextcloud/PcHealth/Disks/laptop/"$(get_file_date)""

    mkdir -p "$path"

    ssd1="/dev/sda"



    ####            Info & health check
    
    ssdLog1="$path/ssd1_check.txt"

    sudo smartctl --all "$ssd1" | tee "$ssdLog1"



    ####            Test disks & partitions

    echo -e "Launching $testType tests for:\n •$ssd1"

    sudo smartctl --test="$testType" "$ssd1"





    ####            Check test progress
    checkTestStatus "$ssd1"

    ssd1TestLog="$path/ssd1_selftest.txt"


    echo -e "\n\nWriting log files:\n• $ssd1TestLog\n"


    ####            Log once the tests are completed
    sudo smartctl -a "$ssd1" | grep -A10 "Self-test" > "$ssd1TestLog"


fi

