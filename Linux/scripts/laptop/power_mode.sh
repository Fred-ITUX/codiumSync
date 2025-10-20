#!/bin/bash


POWER_MODE=$(powerprofilesctl get 2>/dev/null)
case "$POWER_MODE" in
    performance)
        echo "🚀"
        ;;
    balanced)
        echo "⚖️"
        ;;
    power-saver)
        echo "🌱" 
        ;;
    *)
        echo "❓"
        ;;
esac