from libqtile import qtile, layout, hook, bar
from libqtile.config import Key, Click, Drag, Screen, Match, Group
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

import os, subprocess

modkey    = "mod4"
terminal  = guess_terminal()
launcher  = "rofi -show drun -modi drun"
windows   = "rofi -show window -modi window"

keys = [
  Key([modkey], "c", lazy.window.kill()),
  Key([modkey, "shift"], "r", lazy.restart()),
  Key([modkey, "shift"], "e", lazy.shutdown()),
  Key([modkey], "Return", lazy.spawn(terminal)),
  Key([modkey, "shift"], "w", lazy.spawn(windows)),
  Key([modkey], "space", lazy.spawn(launcher)),
  # Move focus to other windows on current stack
  Key([modkey], "left", lazy.layout.left()),
  Key([modkey], "right", lazy.layout.right()),
  Key([modkey], "down", lazy.layout.down()),
  Key([modkey], "up", lazy.layout.up()),
  # Move windows to another position in current stack
  Key([modkey, "shift"], "left", lazy.layout.shuffle_left()),
  Key([modkey, "shift"], "right", lazy.layout.shuffle_right()),
  Key([modkey, "shift"], "down", lazy.layout.shuffle_down()),
  Key([modkey, "shift"], "up", lazy.layout.shuffle_up()),
  # Grow windows in current stack.
  Key([modkey, "control"], "left", lazy.layout.grow_left()),
  Key([modkey, "control"], "right", lazy.layout.grow_right()),
  Key([modkey, "control"], "down", lazy.layout.grow_down()),
  Key([modkey, "control"], "up", lazy.layout.grow_up()),
  Key([modkey], "n", lazy.layout.normalize()),
]

# Change Workspaces
# Move client to another workspace
workspaces = [Group(i) for i in "123456789"]

for i in workspaces:
  keys.extend([
    Key([modkey], i.name, lazy.group[i.name].toscreen()),
    Key([modkey, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True))
  ])

# Add key bindings to switch VTs in Wayland.
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )



layouts = [
    layout.MonadTall(
      margin=10, 
      single_margin=10, 
      single_border_width=4, 
      border_width=4, 
      border_focus="#3b4261", 
      border_normal="#1f2335", 
      auto_minimize=False, 
      auto_fullscreen=False
      ),
]

screens = [
    Screen(top=bar.Gap(50))
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wbm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitkR
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = False
focus_on_window_activation = "smart"
reconfigure_screens = True


# If things like steam games want to auto-minimize themselves when losing focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme
xcursor_theme = "default"
wl_xcursor_size = 24

wmname = "qtiled"

@hook.subscribe.startup_once
def autostart():
  home = os.path.expanduser('~/.config/qtile/scripts/autorun.sh')
  subprocess.call([home])
