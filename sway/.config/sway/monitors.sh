#!/bin/bash

# Function to get the list of all monitor names (active and inactive)
get_all_outputs() {
  swaymsg -t get_outputs | jq -r '.[] | .name'
}

# Function to get the list of active monitor names
get_active_outputs() {
  swaymsg -t get_outputs | jq -r '.[] | select(.active == true) | .name'
}

# Function to get the list of available resolutions for a monitor
get_resolutions() {
  local OUTPUT=$1
  swaymsg -t get_outputs | jq -r ".[] | select(.name == \"$OUTPUT\") | .modes[] | \"\(.width)x\(.height)\""
}

# Function to toggle a monitor (enable/disable)
toggle_monitor() {
  local OUTPUT=$1
  local ACTION=$2
  swaymsg "output $OUTPUT $ACTION"
}

# Function to set the resolution of a monitor
set_resolution() {
  local OUTPUT=$1
  local RESOLUTION=$2
  swaymsg "output $OUTPUT resolution $RESOLUTION"
}

# Function to configure monitors
configure_monitors() {
  # Get a list of all connected monitors (active + inactive)
  ALL_OUTPUTS=$(get_all_outputs)

  # Let the user select which monitor to configure (using fzf)
  SELECTED_OUTPUT=$(echo "$ALL_OUTPUTS" | fzf --prompt="Select monitor to configure: ")

  if [ -z "$SELECTED_OUTPUT" ]; then
    echo "No monitor selected."
    return 1
  fi

  # Get the available resolutions for the selected monitor
  AVAILABLE_RESOLUTIONS=$(get_resolutions "$SELECTED_OUTPUT")

  # Let the user select a resolution (using fzf)
  SELECTED_RESOLUTION=$(echo "$AVAILABLE_RESOLUTIONS" | fzf --prompt="Select resolution for $SELECTED_OUTPUT: ")

  if [ -z "$SELECTED_RESOLUTION" ]; then
    echo "No resolution selected. Skipping resolution change."
  else
    # Set the selected resolution
    set_resolution "$SELECTED_OUTPUT" "$SELECTED_RESOLUTION"
    echo "Resolution set to $SELECTED_RESOLUTION for $SELECTED_OUTPUT."
  fi

  # Ask if the user wants to enable/disable the monitor
  ACTION=$(echo -e "enable\ndisable" | fzf --prompt="Enable or disable $SELECTED_OUTPUT: ")

  if [ -z "$ACTION" ]; then
    echo "No action selected. Skipping monitor toggle."
  else
    # Toggle monitor (enable/disable)
    toggle_monitor "$SELECTED_OUTPUT" "$ACTION"
    echo "$SELECTED_OUTPUT $ACTION."
  fi
}

# Main logic: Allow user to manage monitors
#
# Loop to keep managing monitors until the user decides to exit
while true; do
  configure_monitors
  echo -n "Would you like to manage another monitor? (y/n): "
  read -r RESPONSE
  if [[ ! "$RESPONSE" =~ ^[Yy]$ ]]; then
    break
  fi
done

