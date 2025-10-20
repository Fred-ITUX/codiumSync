#!/bin/bash

ethernetDevice=$(nmcli -g DEVICE con | grep "enp")



nmcli dev disconnect "$ethernetDevice"

sleep 0.5s

nmcli dev connect "$ethernetDevice"

sleep 0.5s

nmcli dev connect "$ethernetDevice"



sleep 0.5s

nordvpn disconnect

nordvpn connect italy
