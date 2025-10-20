#!/bin/bash

while true
	do
	bluetoothctl info > $HOME/Documents/batteryCheckerScript/battery.txt
	
	sleep 1m
done
