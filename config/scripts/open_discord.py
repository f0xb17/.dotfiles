#!/usr/bin/env python3
from libqtile.command.client import InteractiveCommandClient

def focus_discord_workspace():
    c = InteractiveCommandClient()
    discord_window = None
    for window in c.windows():
        wm_class = window['wm_class']
        if wm_class and (any("discord" in cls.lower() for cls in wm_class)):
            discord_window = window
            break
    
    if discord_window:
        c.group[discord_window['group']].toscreen()

if __name__ == "__main__":
    focus_discord_workspace()
