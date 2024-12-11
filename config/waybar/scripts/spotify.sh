#!/bin/sh

# Get the status of Spotify
status=$(playerctl -p spotify status)

if [ "$status" == "Playing" ]; then
    echo $(playerctl --player=spotify metadata --format "{{ artist }} - {{ title }}")
else
    echo "No Track"
fi
