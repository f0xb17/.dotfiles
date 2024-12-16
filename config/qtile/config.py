from libqtile import layout, qtile, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
import os, subprocess

### Variables ###
mod = "mod4"
terminal = "wezterm"
launcher = "rofi -show drun"
window = "rofi -show window"

### Keys ###
keys = [
    # Window Controls
    Key([mod], "left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "down", lazy.layout.down(), desc="Move focus down"),
    Key([mod, "shift"], "left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "up", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "shift"], "down", lazy.layout.shuffle_down(), desc="Move window down"),
    # Spawn Controls
    Key([mod], "return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "escape", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "space", lazy.spawn(launcher), desc="Spawn a command using a prompt widget"),
    Key([mod], "tab", lazy.spawn(window), desc="Spawn a command using a prompt widget"),
    # Qtile Specific
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "e", lazy.shutdown(), desc="Shutdown Qtile"),
]

mouse = [
    # Window Dragging
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

default_layout = dict(
    margin = 10,
    border_width = 4,
    border_normal = "#220000",
    border_focus = "#d75f5f",
    grow_amount = 3,
    border_on_single = 4,
    margin_on_single = 10,
)

layouts = [
    layout.Bsp(name="Bsp", **default_layout),
]

screens = [Screen(),]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Switch to & move focused window to group {i.name}",
            ),
        ]
    )

dgroups_key_binder = None
dgroups_app_rules = []  # type: list21231231232
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),
    Match(wm_class='dialog'),
    Match(wm_class='makebranch'),           
    Match(wm_class='maketag'),
    Match(wm_class='ssh-askpass'),
    Match(title='branchdialog'),
    Match(title='pinentry'),
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
respect_minimize_requests = True

wmname = "Qtile"

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/scripts/autostart.sh')
    subprocess.call(home)

@hook.subscribe.client_new
def dialogs(window):
    if(window.window.get_wm_type() == 'dialog' or window.window.get_wm_transient_for()):
        window.floating = True
