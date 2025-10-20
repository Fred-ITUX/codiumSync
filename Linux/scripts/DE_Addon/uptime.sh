#!/bin/bash

uptime_result=$(uptime | cut -d ',' -f 1 | awk '{print $3, $4}')
echo "🕒 $uptime_result"