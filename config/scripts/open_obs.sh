#!/bin/bash

if pgrep -x "obs" > /dev/null; then
    obs_desktop=$(bspc query -N -n .window -d .all | while read -r node; do
        class_name=$(xprop -id "$node" WM_CLASS)
        if [[ "$class_name" == *"obs"* ]]; then
            bspc query -D -n "$node"
            break
        fi
    done)
    [ -n "$obs_desktop" ] && bspc desktop --focus "$obs_desktop"
else
    obs &
fi
