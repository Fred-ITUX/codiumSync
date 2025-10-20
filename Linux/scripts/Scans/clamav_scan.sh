#!/bin/bash

#### SysInfo & path 
if [ -f ~/.bash_UT ]; then
    . ~/.bash_UT
fi

#### prompt avoid
export DEBIAN_FRONTEND=noninteractive



#dir=$(pwd)
dir="${1:-$(pwd)}"

#### max file size
max_size="5M" 


#### clamscan
#### --remove:              Deletes any infected files it finds.
#### --recursive:           Scans directories recursively.
#### --max-filesize=1000M:  Sets the maximum file size to X MB. (standard 25MB, MAX 1GB, unless modified)
#### --exclude-dir:         Excludes specified directories.
#### --quiet:               Suppresses most output but still shows the final scan summary.

#### log setup - START
echo -e "$(get_sys_Info)
    • Scanning dir: $dir - Max "$max_size"B
    • Clamav signatures DB update..."


#### freshclam update DB (--q suppress output)
sudo freshclam --q

echo -e "    • Signatures DB updated, starting scan"

sudo clamscan --remove --recursive --infected --max-filesize="$max_size"  "$dir" 


#### log standard setup end part (end date)
get_sysInfo_END