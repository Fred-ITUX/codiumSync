#!/bin/bash


cd $HOME

repos=(
    https://github.com/Fred-ITUX/newPc_Install
    https://github.com/Fred-ITUX/phoneScripts
    https://github.com/Fred-ITUX/kdenSync
    https://github.com/Fred-ITUX/codiumSync
    https://github.com/Fred-ITUX/editingUT
    https://github.com/Fred-ITUX/All_Scripts
)



printf '%s\n' "${repos[@]}" \
  | xargs -I{} bash -c 'echo -e "\n\t• Cloning {}\n" && git clone "{}"' 

