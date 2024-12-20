#!/bin/bash

if pgrep -x "discord" > /dev/null || pgrep -x "discord-canary" > /dev/null; then
    discord_desktop=$(bspc query -N -n .window -d .all | while read -r node; do
        class_name=$(xprop -id "$node" WM_CLASS)
        if [[ "$class_name" == *"discord"* || "$class_name" == *"Discord-Canary"* ]]; then
            bspc query -D -n "$node"
            break
        fi
    done)
    [ -n "$discord_desktop" ] && bspc desktop --focus "$discord_desktop"
else
    discord &
fi
