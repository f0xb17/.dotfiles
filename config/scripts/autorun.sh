#!/bin/sh

feh --bg-scale --zoom fill ~/.config/bspwm/01.jpg

picom --config ~/.config/picom/picom.conf & disown

polybar &
dunst &

gnome-keyring-daemon --start --components=ssh,secrets,pkcs11,login & disown

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1  & disown
