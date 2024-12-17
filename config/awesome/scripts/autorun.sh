#!/bin/bash

gnome-keyring-daemon --start --components=ssh,secrets,pkcs11,login &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
dbus-update-activation-environment --all &
picom --config ~/.config/picom/picom.conf -b &
polybar
