#!/bin/sh

# Switch between keyboard layouts
current_layout=$(setxkbmap -query | awk 'NR==3{print $2}')

if [ "$current_layout" = "de" ] ; then 
  setxkbmap "us"
else
  setxkbmap "de"
fi
