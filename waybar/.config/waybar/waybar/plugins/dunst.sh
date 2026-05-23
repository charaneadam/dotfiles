#!/bin/bash

# Check if Dunst is paused (Do Not Disturb)
COUNT=$(dunstctl count history)
PAUSED=$(dunstctl is-paused)

if [ "$PAUSED" == "true" ]; then
    if [ "$COUNT" -gt 0 ]; then
        CLASS="dnd-notification"
    else
        CLASS="dnd-none"
    fi
else
    if [ "$COUNT" -gt 0 ]; then
        CLASS="notification"
    else
        CLASS="none"
    fi
fi

echo "{\"alt\": \"$CLASS\", \"class\": \"$CLASS\", \"text\": \"$COUNT\"}"
