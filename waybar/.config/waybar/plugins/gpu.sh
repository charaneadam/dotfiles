#!/bin/bash

if ! hyprctl monitors | grep -q "HDMI-A-2"; then
    echo ""
    exit 0
fi

# Get GPU Data (Usage and Temp) using nvidia-smi "Usage% | Temp°C"
GPU_DATA=$(nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits | awk -F', ' '{print $1"% | "$2"°C"}')

# Output JSON for Waybar
echo "{\"text\": \"󰾲 $GPU_DATA\", \"tooltip\": \"NVIDIA GPU on HDMI-A-2\"}"
