# Copyright (c) 2010 Aldo Cortesi Copyright (c) 2010, 2014 dequis Copyright (c)
# 2012 Randall Ma Copyright (c) 2012-2014 Tycho Andersen Copyright (c) 2012
# Craig Barnes Copyright (c) 2013 horsik Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess
from pathlib import Path

from libqtile import bar, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.layout import max, floating, xmonad, columns
from libqtile.lazy import lazy

from qtile_extras.widget import (
    TaskList,
    QuickExit,
    GlobalMenu,
    Prompt,
    Spacer,
    GroupBox,
    StatusNotifier,
    CurrentLayoutIcon,
    UPowerWidget,
    Volume,
    Clock,
    WiFiIcon,
)
from qtile_extras.widget.decorations import RectDecoration

from key_config import keys

# from qtile_extras.popup.toolkit import PopupRelativeLayout, PopupImage, PopupText


mod = "mod4"
terminal = "wezterm"
browser = "brave"
file_manager = "thunar"


scripts = str(Path.home()) + "/.config/qtile/scripts/"


colors = []
colors_path = str(Path.home()) + "/.cache/wal/colors"


def load_colors(cache):
    with open(cache, "r") as file:
        for line in file:
            colors.append(line.strip())
    colors.append("#ffffff")
    lazy.reload()


load_colors(colors_path)


groups = [Group(name=i, label="󰮠 ") for i in "1234"]

for i in groups:
    keys.extend(
        [
            # mod1 + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )
#
layouts = [
    columns.Columns(
        border_width=2,
        margin=3,
        margin_on_single=3,
        border_on_single=True,
        border_focus=colors[3],
        border_normal=colors[2],
    ),
    max.Max(),
    xmonad.MonadTall(
        border_width=2,
        margin=3,
        margin_on_single=3,
        border_on_single=True,
        border_focus=colors[3],
        border_normal=colors[2],
    ),
    floating.Floating(
        border_focus=colors[3],
        border_normal=colors[2],
    ),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="IBM Plex Sans",
    fontsize=12,
    padding_x=3,
    padding_y=0,
)
extension_defaults = widget_defaults.copy()

decoration_group = {
    "decorations": [
        RectDecoration(
            colour=colors[0],
            radius=12,
            filled=True,
            padding_y=3,
            group=True,
        )
    ],
    "padding": 10,
}


screens = [
    Screen(
        top=bar.Bar(
            [
                QuickExit(
                    foreground=colors[15],
                    default_text=" ",
                    countdown_format="  {}",
                    **decoration_group,
                ),
                Prompt(**decoration_group),
                GlobalMenu(**decoration_group),
                Spacer(),
                GroupBox(
                    active=colors[5],
                    inactive=colors[6],
                    borderwidth=3,
                    highlight_method="block",
                    this_current_screen_border=colors[0],
                    **decoration_group,
                ),
                CurrentLayoutIcon(
                    scale=0.6,
                    **decoration_group,
                ),
                # Spacer(length=610),
                TaskList(
                    border=colors[9],
                    highlight_method="block",
                    foreground=colors[6],
                    borderwidth=1,
                    margin_y=3,
                    padding_y=3,
                    parse_text=lambda _: "",
                    markup_focused="",
                    txt_floating="",
                    txt_maximized="",
                    txt_minimized="",
                ),
                Spacer(),
                # TaskList(
                #     highlight_method="block",
                #     parse_text=lambda _: "",
                #     **decoration_group,
                # ),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                StatusNotifier(**decoration_group),
                Volume(
                    emoji=True,
                    emoji_list=["", "", "", ""],
                    **decoration_group,
                ),
                WiFiIcon(interface="wlan0", padding_y=8, **decoration_group),
                UPowerWidget(**decoration_group),
                Clock(format="%a%d %m | %H:%M", **decoration_group),
            ],
            28,
            background="#00000000",
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders
            # are magenta
        ),
        wallpaper="~/.config/qtile/wallpaper/wallpaper1.jpg",
        wallpaper_mode="stretch",
        # You can uncomment this variable if you see that on X11 floating
        # resize/moving is laggy By default we handle these events delayed to
        # already improve performance, however your system might still be
        # struggling This variable is set to None (no cap) by default, but you
        # can set it to 60 to indicate that you limit it to 60 events per
        # second
        x11_drag_polling_rate=60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = floating.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *floating.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
    border_focus=colors[3],
    border_normal=colors[2],
    border_width=1,
)
auto_fullscreen = True
focus_on_window_activation = "focus"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
# wmname = "LG3D"

wmname = "qtile"


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.Popen([home])


@hook.subscribe.setgroup
def change_group():
    for group in qtile.groups:
        if group.label != "󰮠 " and group != qtile.current_group:
            group.set_label("󰮠 ")
    qtile.current_group.set_label("")
