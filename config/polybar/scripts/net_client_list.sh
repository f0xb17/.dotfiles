#!/bin/bash

# Get the active window ID
active_window=$(xprop -root _NET_ACTIVE_WINDOW | awk '{print $5}')

# Get the current desktop ID
current_desktop=$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}')

# Get the list of all window IDs
window_list=$(xprop -root _NET_CLIENT_LIST | grep -o '0x[0-9a-fA-F]\+')

output=""

# Loop through each window ID and exclude the active window and Spotify
for window in $window_list; do
  window_desktop=$(xprop -id $window _NET_WM_DESKTOP | awk '{print $3}')
  if [ "$window" != "$active_window" ] && [ "$window_desktop" == "$current_desktop" ]; then
    window_name=$(xprop -id $window _NET_WM_NAME | grep -o '".*"' | tr -d '\"')
    wm_class=$(xprop -id $window WM_CLASS)
    output+=" [ $window_name ]  "
  fi
done

# Remove trailing separator
output=${output% | }

echo "$output"
