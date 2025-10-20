#!/bin/bash

### Command outputs
### gamemode is inactive
### gamemode is active

Status=$(gamemoded -s)
Active="gamemode is active"

## check active status
if [[ $Status == $Active ]]; then
    echo "👾"
## time break && re-assing
else
    echo ""
fi