#!/bin/bash

vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%.0f", $2 * 100}')

# Show notification with progress bar
dunstify -a "volume" -r 6969 -u low -h int:value:"$vol" "Volume" "$vol%"
