from libqtile import qtile
from libqtile.config import Key
from libqtile.lazy import lazy
from pathlib import Path

mod = "mod4"
terminal = "wezterm"
browser = "brave"
file_manager = "thunar"

scripts = str(Path.home()) + "/.config/qtile/scripts/"


@lazy.function
def show_desktop(qtile):
    for window in qtile.current_group.windows:
        window.toggle_minimize()


@lazy.window.function
def window_to_nearest_group(window, direction):
    window.togroup(
        window.qtile.groups[
            (window.qtile.groups.index(window.group) + direction)
            % len(window.qtile.groups)
        ].name,
        switch_group=True,
    )


@lazy.group.function
def switch_window(group, to_window):
    getattr(group, to_window)()
    group.current_window.bring_to_front()
    if group.current_window.minimized:
        group.current_window.toggle_minimize()


keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key(
        [mod],
        "h",
        lazy.group.prev_window().when(layout="floating"),
        lazy.layout.left(),
        desc="Move focus to left",
    ),
    Key(
        [mod],
        "l",
        lazy.group.next_window().when(layout="floating"),
        lazy.layout.right(),
        desc="Move focus to right",
    ),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [mod, "control"],
        "h",
        lazy.layout.grow_left().when(layout=["bsp", "columns"]),
        lazy.layout.grow().when(layout=["monadtall", "monadwide", "monadthreecol"]),
        desc="Grow window to the left",
    ),
    Key(
        [mod, "control"],
        "l",
        lazy.layout.grow_right().when(layout=["bsp", "columns"]),
        lazy.layout.grow().when(layout=["monadtall", "monadwide", "monadthreecol"]),
        desc="Grow window to the right",
    ),
    Key(
        [mod, "control"],
        "j",
        lazy.layout.grow_down().when(layout=["bsp", "columns"]),
        lazy.layout.shrink().when(layout=["monadtall", "monadwide", "monadthreecol"]),
        desc="Grow window down",
    ),
    Key(
        [mod, "control"],
        "k",
        lazy.layout.grow_up().when(layout=["bsp", "columns"]),
        lazy.layout.shrink().when(layout=["monadtall", "monadwide", "monadthreecol"]),
        desc="Grow window up",
    ),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key(
        ["mod1"],
        "Tab",
        switch_window("prev_window"),
        desc="Switch window focus to other window",
    ),
    Key(
        ["mod1", "shift"],
        "Tab",
        switch_window("next_window"),
        desc="Switch window focus to other window",
    ),
    Key(
        [mod],
        "d",
        lazy.window.toggle_minimize(),
        lazy.layout.previous(),
        desc="Minimize window",
    ),
    Key([mod, "shift"], "d", show_desktop, desc="Show desktop"),
    Key(
        [mod],
        "w",
        lazy.window.toggle_maximize(),
        desc="Toggle window between minimum and maximum sizes",
    ),
    Key(
        [mod, "shift"],
        "w",
        lazy.window.toggle_fullscreen(),
        desc="Toggle window fullscreen",
    ),
    # Move to next/previous group
    Key(
        [mod, "control"],
        "Left",
        lazy.screen.prev_group(),
        desc="Move to previous group",
    ),
    Key([mod, "control"], "Right", lazy.screen.next_group(), desc="Move to next group"),
    Key(
        [mod, "control", "shift"],
        "Left",
        window_to_nearest_group(-1),
        desc="Move window to previous group",
    ),
    Key(
        [mod, "control", "shift"],
        "Right",
        window_to_nearest_group(1),
        desc="Move window to next group",
    ),
    # Toggle between split and unsplit sides of stack. Split = all windows
    # displayed Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key(["mod1", "control"], "t", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "x", lazy.spawn(browser), desc="Launch browser"),
    Key([mod], "e", lazy.spawn(file_manager), desc="Launch file manager"),
    # Toggle between different layouts as defined below
    Key([mod], "backslash", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "backslash", lazy.prev_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "space", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod, "shift"], "c", lazy.spawn("xcolor -s"), desc="pick color"),
    # Key([mod], "Print", lazy.spawn("xfce4-screenshooter"), desc="Take a screenshot"),
    # Key(
    #     [mod, "shift"],
    #     "Print",
    #     lazy.spawn("xfce4-screenshooter -rc"),
    #     desc="Take a screenshot",
    # ),
    Key(
        [mod, "shift"],
        "Print",
        lazy.spawn("flameshot gui --clipboard"),
        desc="Take a screenshot",
    ),
    # Key(
    #     [mod, "control"],
    #     "Print",
    #     lazy.spawn("xfce4-screenshooter -w --no-border"),
    #     desc="Take a screenshot",
    # ),
    Key(
        [mod],
        "Print",
        lazy.spawn("flameshot full"),
        desc="Take a screenshot",
    ),
    # Key(
    #     [mod, "control", "shift"],
    #     "Print",
    #     lazy.spawn("xfce4-screenshooter -fm"),
    #     desc="Take a screenshot",
    # ),
    Key(
        [mod, "control"],
        "Print",
        lazy.spawn("flameshot gui --region all"),
        desc="Take a screenshot",
    ),
    # Key(
    #     [mod],
    #     "v",
    #     lazy.spawn("xfce4-clipman-history"),
    #     desc="Show clipboard history",
    # ),
    Key(
        [mod],
        "v",
        lazy.spawn("copyq menu"),
        desc="Show clipboard history",
    ),
    Key(
        ["control"],
        "Escape",
        lazy.spawn("xfce4-taskmanager"),
        desc="Launch task manager",
    ),
    # Brightness
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn(scripts + "brightness-control.sh up"),
    ),
    Key(
        ["mod1", "control"],
        "p",
        lazy.spawn(scripts + "brightness-control.sh up"),
    ),  # Aument Brightness
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn(scripts + "brightness-control.sh down"),
    ),
    Key(
        ["mod1", "control"],
        "o",
        lazy.spawn(scripts + "brightness-control.sh down"),  # Diminish Brightness
    ),
    # Volume
    Key([], "XF86AudioMute", lazy.spawn(scripts + "volume-control.sh mute")),  # Mute
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn(scripts + "volume-control.sh down"),
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn(
            scripts + "volume-control.sh up",
        ),
    ),
    Key(
        ["mod1"],
        "XF86AudioMute",
        lazy.spawn(scripts + "volume-control.sh mic-mute"),
    ),  # Mute
    Key(
        ["mod1"],
        "XF86AudioLowerVolume",
        lazy.spawn(scripts + "volume-control.sh mic-down"),
    ),
    Key(
        ["mod1"],
        "XF86AudioRaiseVolume",
        lazy.spawn(scripts + "volume-control.sh mic-up"),
    ),  # Raise Volume
    # Media Control
    Key(
        [], "XF86AudioPlay", lazy.spawn("playerctl --player=%any play-pause")
    ),  # Play Pause
    Key([], "XF86AudioNext", lazy.spawn("playerctl --player=%any next")),  # Next song
    Key(
        [], "XF86AudioPrev", lazy.spawn("playerctl --player=%any previous")
    ),  # Previous Song
]

# Add key bindings to switch VTs in Wayland. We can't check qtile.core.name in
# default config as it is loaded before qtile is started We therefore defer the
# check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )
