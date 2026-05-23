#!/bin/bash

# Get official pacman updates
# checkupdates is part of the 'pacman-contrib' package
pacman_updates=$(checkupdates 2>/dev/null | wc -l)

# Get AUR updates via yay
yay_updates=$(yay -Qum 2>/dev/null | wc -l)

total=$((pacman_updates + yay_updates))

if [ "$total" -gt 0 ]; then
    # Output JSON for Waybar
    # Alt field allows us to change the icon color in CSS if needed
    echo "{\"text\": \"󰚰 $total\", \"tooltip\": \"Pacman: $pacman_updates\nAUR: $yay_updates\"}"
else
    echo ""
fi
