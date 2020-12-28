from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Screen, Match
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import os, subprocess, platform

mod = "mod4"
terminal = "st"
run_command = 'rofi -show drun -config ~/.config/rofi/themes/center.rasi -display-drun "Run: " -drun-display-format "{name}"'
find_command = 'rofi -show find -modi find:~/.local/share/rofi/finder.sh -config ~/.config/rofi/themes/center.rasi -display-drun "Find: " -drun-display-format "{name}"'
# run_command = "dmenu_run -p 'Run: '"


######## AUTOSTART ########
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~")
    subprocess.Popen([home + "/.config/qtile/autostart.sh"])


####### KEYS #######
keys = [
    ####### ESSENTIALS
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "space", lazy.spawn(run_command), desc="Run Launcher"),
    Key(["mod1"], "space", lazy.spawn(run_command), desc="Run Launcher"),
    Key([mod, "shift"], "Return", lazy.spawn(run_command), desc="Run Launcher"),
    Key([mod], "f", lazy.spawn(find_command), desc="Run finder"),
    Key([mod, "mod1"], "space", lazy.spawn(find_command), desc="Run finder"),
    Key([mod], "e", lazy.spawn("thunar"), desc="Run file explorer"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    ####### WINDOWS
    Key([mod], "j", lazy.layout.down(), desc="Move focus down in stack pane"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up in stack pane"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down in current stack ",),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up in current stack ",),
    Key([mod], "l", lazy.layout.grow(), lazy.layout.increase_nmaster(), desc="Expand window (MonadTall)",),
    Key([mod], "h", lazy.layout.shrink(), lazy.layout.decrease_nmaster(), desc="Shrink window (MonadTall)",),
    Key([mod], "n", lazy.layout.normalize(), desc="normalize window size ratios"),
    Key([mod], "m", lazy.window.maximize(), desc="toggle maximize"),
    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc="toggle floating"),
    Key([mod, "shift"], "m", lazy.window.toggle_fullscreen(), desc="toggle fullscreen"),
    ####### STACK CONTROL
    Key([mod, "shift"], "space",
        lazy.layout.rotate(),
        lazy.layout.flip(),
        desc="Switch which side main pane occupies (XmonadTall)",
    ),
    Key([mod], "Tab",
        lazy.layout.next(),
        desc="Switch window focus to other pane(s) of stack",
    ),
    Key([mod, "control"], "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod, "shift"], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    ####### SCREENS
    Key([mod], "period", lazy.next_screen(), desc='Move focus to next monitor'),
    Key([mod], "comma", lazy.prev_screen(), desc='Move focus to prev monitor'),
    ####### AUDIO
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -c 0 sset Master 2+ unmute")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -c 0 sset Master 2- unmute")),
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    Key([], "XF86AudioPlay",
        lazy.spawn(
            "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"
        ),
    ),
    Key([], "XF86AudioNext",
        lazy.spawn(
            "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"
        ),
    ),
    Key([], "XF86AudioPrev",
        lazy.spawn(
            "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"
        ),
    ),
    ####### BACKLIGHT
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 10")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 10")),
    ####### OPEN APPLICATIONS
    Key([mod], "w", lazy.spawn("firefox")),
    Key([mod], "b", lazy.spawn("firefox")),
    Key([mod], "m", lazy.spawn("thunderbird")),
    Key([mod], "v", lazy.spawn("st -e nvim")),
    Key([mod], "t", lazy.spawn("emacs")),
]

####### DEFINE COLORS #######
colors = [
    ["#282c34", "#282c34"],  # panel background
    ["#434758", "#434758"],  # font color for inactive group names
    ["#ffffff", "#ffffff"],  # font color for active group names
    ["#ff5555", "#ff5555"],  # 3 red
    ["#8d62a9", "#8d62a9"],  # 4 violet
    ["#668bd7", "#668bd7"],  # 5 blue
    ["#e1acff", "#e1acff"],  # 6 light pink
    ["#00b2b3", "#00b2b3"],  # 7 teal
    ["#ee2677", "#ee2677"],  # 8 pink
    ["#fc773e", "#fc773e"],  # 9 orange
    ["#ffd700", "#ffd700"],  # 10 yellow
    ["#cce1e1", "#cce1e1"],  # 11 pastel green
    ["#c6e2ff", "#c6e2ff"],  # 12 pastel blue
    ["#cccce1", "#cccce1"],  # 13 pastel violet
]


####### GROUPS #######
group_names = [
    ("www", {"layout": "monadtall", "spawn": "firefox"}),
    ("dev", {"layout": "monadtall"}),
    ("music", {"layout": "monadtall", "spawn": "spotify"}),
    ("mail", {"layout": "monadtall", "spawn": "thunderbird"}),
    ("game", {"layout": "floating"}),
    ("x", {"layout": "monadtall"}),
    ("y", {"layout": "monadtall"}),
    ("z", {"layout": "monadtall"}),
]
groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(
        Key([mod], str(i), lazy.group[name].toscreen())
    )  # Switch to another group
    keys.append(
        Key([mod, "shift"], str(i), lazy.window.togroup(name))
    )  # Send current window to another group


####### LAYOUTS #######
layouts = [
    layout.Max(),
    layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),
    layout.MonadTall(margin=8, border_width=2, border_focus=colors[8][0]),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
    layout.Floating(),
]

####### WIDGETS #######
widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

sep1 = widget.TextBox("|", padding=1, fontsize=26, background=colors[0], foreground=colors[1])
sep2 = widget.TextBox("|", padding=1, fontsize=26, background=colors[0], foreground=colors[1])

widget_list = [
    widget.CurrentLayoutIcon(foreground=colors[2], bakcground=colors[0]),
    widget.Sep(linewidth=0, padding=6, background=colors[0]),
    widget.GroupBox(
        active=colors[2],
        inactive=colors[1],
        rounded=False,
        highlight_color=colors[4],
        highlight_method="line",
        foreground=colors[2],
        background=colors[0],
        borderwidth=3,
        padding_x=3,
        padding_y=5,
        margin_x=0,
        margin_y=3,
    ), ########################################################################
    widget.WindowName(foreground=colors[6], background=colors[0]),
    widget.Mpris2(
        name="spotify",
        objname="org.mpris.MediaPlayer2.spotify",
        display_metadata=["xesam:title", "xesam:artist"],
        scroll_chars=None,
        stop_pause_text="",
        foreground=colors[9],
        background=colors[0],
    ),
    sep1, #####################################################################
    widget.TextBox("{}".format(platform.release()), background=colors[0], foreground=colors[1]),
    sep2, #####################################################################
    widget.TextBox(
        text=" ⟳",
        padding=2,
        fontsize=14,
        foreground=colors[3],
        background=colors[0],
    ),
    widget.CheckUpdates(
        update_interval=1800,
        mouse_callbacks={
            "Button1": lambda qtile: qtile.cmd_spawn(terminal + " -e sudo pacman -Syu")
        },
        foreground=colors[3],
        background=colors[0],
    ),
    widget.TextBox(
        text="Updates",
        padding=5,
        mouse_callbacks={
            "Button1": lambda qtile: qtile.cmd_spawn(terminal + " -e sudo pacman -Syu")
        },
        foreground=colors[3],
        background=colors[0],
    ),
    sep1, #####################################################################
    widget.TextBox(
        text=" 🖬", fontsize=16, padding=0,
        foreground=colors[5], background=colors[0]
    ),
    widget.Memory(
        padding=5,
        mouse_callbacks={
            "Button1": lambda qtile: qtile.cmd_spawn(terminal + " -e htop")
        },
        foreground=colors[5],
        background=colors[0],
    ),
    sep2, #####################################################################
    widget.Battery(padding=5, foreground=colors[8], background=colors[0]),
    sep1, #####################################################################
    widget.TextBox(text="Vol:", foreground=colors[10], background=colors[0]),
    widget.Volume(padding=5, foreground=colors[10], background=colors[0]),
    sep1, #####################################################################
    widget.KeyboardLayout(
        configured_keyboards=["us", "gb"],
        option="ctrl:nocaps,'shift:both_capslock",
        foreground=colors[6],
        background=colors[0],
    ),
    sep2, #####################################################################
    widget.Clock(
        format="%Y-%m-%d %a %I:%M %p",
        foreground=colors[7], background=colors[0]
    ),
    widget.Systray(background=colors[0]),
    # widget.QuickExit(),
]


####### SCREENS #######
@hook.subscribe.screen_change
def restart_on_randr(qtile, ev):
	qtile.cmd_restart()

from Xlib import X, display
from Xlib.ext import randr

d = display.Display()
s = d.screen()
r = s.root
res = r.xrandr_get_screen_resources()._data
# Dynamic multiscreen! (Thanks XRandr)
num_screens = 0
for output in res['outputs']:
    print("Output %d:" % (output))
    mon = d.xrandr_get_output_info(output, res['config_timestamp'])._data
    print("%s: %d" % (mon['name'], mon['num_preferred']))
    if mon['num_preferred']:
        num_screens += 1
print("%d screens found!" % (num_screens))

bar1 = bar.Bar(widget_list, size=20, margin=[0, 0, 3, 0], opacity=1)
bar2 = bar.Bar(widget_list, size=20, margin=[0, 0, 3, 0], opacity=1)

# screens = []
# for _ in range(num_screens):
#     screens.append(Screen(top=bar.Bar(widget_list, size=20, margin=[0, 0, 0, 0], opacity=1)))

if num_screens == 2:
    screens = [Screen(), Screen(top=bar2)]
else:
    screens = [Screen(top=bar1)]


####### FLOATING LAYOUT #######
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        {"wmclass": "confirm"},
        {"wmclass": "dialog"},
        {"wmclass": "download"},
        {"wmclass": "error"},
        {"wmclass": "file_progress"},
        {"wmclass": "notification"},
        {"wmclass": "splash"},
        {"wmclass": "toolbar"},
        {"wmclass": "confirmreset"},  # gitk
        {"wmclass": "makebranch"},  # gitk
        {"wmclass": "maketag"},  # gitk
        {"wname": "branchdialog"},  # gitk
        {"wname": "pinentry"},  # GPG key password entry
        {"wmclass": "ssh-askpass"},  # ssh-askpass
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"



# @hook.subscribe.startup_once
# def start_once():
#     home = os.path.expanduser('~')
#     subprocess.call(['~/.config/qtile/autostart.sh'])
# # start_once()


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
