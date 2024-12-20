#!/usr/bin/env python3
from libqtile.command.client import InteractiveCommandClient

def focus_obs_workspace():
    c = InteractiveCommandClient()
    obs_window = None
    for window in c.windows():
        wm_class = window['wm_class']
        if wm_class and (any("obs" in cls.lower() for cls in wm_class)):
            obs_window = window
            break
    
    if obs_window:
        c.group[obs_window['group']].toscreen()
    else:
        os.system("obs &")

if __name__ == "__main__":
    focus_obs_workspace()
