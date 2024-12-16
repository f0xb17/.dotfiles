#!/bin/sh

dbus-update-activation-environment --all &
gnome-keyring-daemon --start --components=ssh,secrets,pkcs11,login &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
feh --bg-scale --zoom fill /home/$(whoami)/Pictures/Wallpapers/backiee-214272-landscape.jpg &
picom --config ~/.config/picom/picom.conf -b &
polybar
