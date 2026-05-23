#!/bin/bash

# Check if there are any notifications currently displayed on screen
# We use dunstctl count displayed for this
ACTIVE=$(dunstctl count displayed)

if [ "$ACTIVE" -gt 0 ]; then
    # If notifications are visible, close them all (Hide)
    dunstctl close-all
else
    # If none are visible, pop the entire history (Show All)
    # We loop through the count of history to pop everything at once
    COUNT=$(dunstctl count history)
    for ((i=0; i<COUNT; i++)); do
        dunstctl history-pop
    done
fi
