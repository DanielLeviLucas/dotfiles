# -*- coding: utf-8 -*-
import os
import socket
import subprocess
import psutil
from libqtile import qtile
from libqtile.config import Click, Drag, Key, Match, Screen, Group, KeyChord
from libqtile import layout, bar, hook
from libqtile.lazy import lazy

from qtile_extras import widget
from qtile_extras.widget.decorations import BorderDecoration

HOME_DIR = os.path.expanduser('~')

mod = "mod4"              # Sets mod key to SUPER/WINDOWS
myTerm = "kitty"          # My terminal of choice


keys = [
    # The essentials
    Key([mod], "Return",
        lazy.spawn(myTerm),
        desc='Launches My Terminal'
        ),
    Key([mod, "shift"], "Return",
        lazy.spawn("rofi -show drun"),
        desc='Run Launcher'
        ),
   Key([mod, "shift"], "s",
        lazy.spawn("scrot -s -q 100 -z 0 -f"),
        desc='capture a selected area'
        ),
    Key([mod], "v",
        lazy.spawn("copyq toggle"),
        desc='Show copyq menu'
        ),
    Key([mod, "shift"], "v",
        lazy.spawn('copyq menu'),
        desc='Show copyq context menu'
        ),
    Key([mod], "Tab",
        lazy.next_layout(),
        desc='Toggle through layouts'
        ),
    Key([mod, "shift"], "c",
        lazy.window.kill(),
        desc='Kill active window'
        ),
    Key([mod, "shift"], "r",
        lazy.restart(),
        desc='Restart Qtile'
        ),
    KeyChord([mod], 'r', [
            Key([], 'r', lazy.spawn("rofi -show drun"), desc='rofi drun'),
            Key([], 'p', lazy.spawn("rofi -show run"), desc='rofi run'),
           ],
           mode=True,
           name='rofi Launcher'
    ),
    Key([mod, "shift"], "q",
        lazy.window.kill(),
        desc='Kill active window'
        ),
    Key([mod], "w",
        lazy.to_screen(1),
        desc='Keyboard focus to monitor 2'
        ),
    Key([mod], "e",
        lazy.to_screen(0),
        desc='Keyboard focus to monitor 1'
        ),
    # Switch focus of monitors
    Key([mod], "period",
        lazy.next_screen(),
        desc='Move focus to next monitor'
        ),
    Key([mod], "comma",
        lazy.prev_screen(),
        desc='Move focus to prev monitor'
        ),
    # Treetab controls
    Key([mod, "shift"], "h",
        lazy.layout.move_left(),
        desc='Move up a section in treetab'
        ),
    Key([mod, "shift"], "l",
        lazy.layout.move_right(),
        desc='Move down a section in treetab'
        ),
    # Window controls
    Key([mod], "j",
        lazy.layout.down(),
        desc='Move focus down in current stack pane'
        ),
    Key([mod], "k",
        lazy.layout.up(),
        desc='Move focus up in current stack pane'
        ),
    Key([mod, "shift"], "j",
        lazy.layout.shuffle_down(),
        lazy.layout.section_down(),
        desc='Move windows down in current stack'
        ),
    Key([mod, "shift"], "k",
        lazy.layout.shuffle_up(),
        lazy.layout.section_up(),
        desc='Move windows up in current stack'
        ),
    Key([mod], "h",
        lazy.layout.shrink(),
        lazy.layout.decrease_nmaster(),
        desc='Shrink window (MonadTall)'
        ),
    Key([mod], "l",
        lazy.layout.grow(),
        lazy.layout.increase_nmaster(),
        desc='Expand window (MonadTall)'
        ),
    Key([mod], "n",
        lazy.layout.normalize(),
        desc='normalize window size ratios'
        ),
    Key([mod], "m",
        lazy.layout.maximize(),
        desc='toggle window between minimum and maximum sizes'
        ),
    Key([mod], "f",
        lazy.window.toggle_fullscreen(),
        desc='toggle fullscreen'
        ),
    # Stack controls
    Key([mod, "shift"], "Tab",
        lazy.layout.rotate(),
        lazy.layout.flip(),
        desc='Switch which side main pane occupies (XmonadTall)'
        ),
    Key([mod], "space",
        lazy.layout.next(),
        desc='Switch window focus to other pane(s) of stack'
        ),
    Key([mod, "shift"], "space",
        lazy.spawn("setxkbmap us dvorak"),
        desc='Chage keyboard layout to Dvorak'
        ),
    KeyChord([mod], 'p', [
            Key([], 'p', lazy.spawn("player-play-pause"), desc='spotify player play/pause'),
            Key([], 'n', lazy.spawn("playerctl --player=spotify next "), desc='spotify player next track'),
            Key([], 'b', lazy.spawn("playerctl --player=spotify previous "), desc='spotify player previous track'),
           ],
           mode=True,
           name='Spotify player controls'
    ),
    Key([mod, "shift"], "p",
        lazy.spawn("player-play-pause"),
        desc='Toggle play/pause in spotify'
        ),
    Key([mod, "shift"], "y",
        lazy.spawn("screenkey --font-size small --opacity 0.4"),
        desc='launch screenKey'
        ),
    Key([mod], "u",
        lazy.spawn(f"{HOME_DIR}/.local/bin/change-volume up"),
        desc='change volume up'
        ),
    Key([mod, "shift"], "u",
        lazy.spawn(f"{HOME_DIR}/.local/bin/change-volume down"),
        desc='Change volume down'
        ),
]

group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
group_labels = group_names
group_layouts = ["monadtall"] * 10

groups = []
for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=False),
                desc="Move focused window to group {}".format(i.name),
            ),
        ]
    )



layout_theme = {
    "border_width": 1,
    "margin": 4,
    "border_focus": "F6C177",
    "border_normal": "1D2330"
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Stack(num_stacks=2),
    layout.RatioTile(**layout_theme),
    layout.TreeTab(
        font="Ubuntu",
        fontsize=10,
        sections=["FIRST", "SECOND", "THIRD", "FOURTH"],
        section_fontsize=10,
        border_width=2,
        bg_color="1c1f24",
        active_bg="c678dd",
        active_fg="000000",
        inactive_bg="a9a1e1",
        inactive_fg="1c1f24",
        padding_left=0,
        padding_x=0,
        padding_y=5,
        section_top=10,
        section_bottom=20,
        level_shift=8,
        vspace=3,
        panel_width=200
    ),
    layout.Floating(**layout_theme)
]

colors = [
          ["#282c34", "#282c34"],
          ["#1c1f24", "#1c1f24"],
          ["#dfdfdf", "#dfdfdf"],
          ["#ff6c6b", "#ff6c6b"],
          ["#98be65", "#98be65"],
          ["#da8548", "#da8548"],
          ["#51afef", "#51afef"],
          ["#c678dd", "#c678dd"],
          ["#46d9ff", "#46d9ff"],
          ["#a9a1e1", "#a9a1e1"],
          ["#F6C177", "#F6C177"],
         ]

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

# DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font="Ubuntu Bold",
    fontsize=12,
    padding=6,
    background=colors[0]
)
extension_defaults = widget_defaults.copy()


def init_widgets_list():
    widgets_list = [
        widget.Image(
            filename="~/.config/qtile/icons/witcher_26x26.png",
            scale="True",
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn(myTerm)
            }
        ),
        widget.Spacer(length = 1), 
        widget.GroupBox(
            font="Ubuntu Bold",
            fontsize=16,
            margin_y=5,
            margin_x=3,
            padding_y=5,
            padding_x=3,
            borderwidth=3,
            active=colors[2],
            inactive=colors[7],
            rounded=False,
            highlight_color=colors[1],
            highlight_method="line",
            this_current_screen_border=colors[6],
            this_screen_border=colors[4],
            other_current_screen_border=colors[6],
            other_screen_border=colors[4],
            foreground=colors[2],
            background=colors[0]
        ),
        widget.TextBox(
            text='•',
            font="Ubuntu Mono",
            background=colors[0],
            foreground='FFFFFF',
            padding=6,
            fontsize=18
        ),
        widget.Spacer(length = 8),
        widget.CurrentLayoutIcon(
            custom_icon_paths=[
                os.path.expanduser("~/.config/qtile/icons")
            ],
            foreground=colors[2],
            background=colors[0],
            padding=0,
            scale=0.6
        ),
        widget.CurrentLayout(
            foreground=colors[2],
            fontsize=14,
            background=colors[0],
            padding=5
        ),
        widget.TextBox(
            text=' ',
            font="Ubuntu Mono",
            background=colors[0],
            foreground='474747',
            padding=2,
            fontsize=14
        ),
        widget.WindowName(
            foreground=colors[6],
            background=colors[0],
            fontsize=14,
            padding=0
        ),
        widget.Spacer(length = 8),
        widget.Clipboard(
            foreground=colors[7],
            background=colors[0],
            mouse_callbacks={
                'Button3': lambda: qtile.cmd_spawn('copyq toggle')
            },
            fmt='󱉧 {}',
            decorations=[
                BorderDecoration(
                    colour=colors[7],
                    border_width=[0, 0, 2, 0],
                )
            ],
        ),
        widget.Spacer(length = 8),
        widget.Net(
            interface="enp4s0",
            format='󰀂  {down} 󰳜󰳢{up}',
            foreground=colors[3],
            background=colors[0],
            decorations=[
                      BorderDecoration(
                          colour=colors[3],
                          border_width=[0, 0, 2, 0],
                      )
            ],
        ),
        widget.Spacer(length = 8),
        widget.ThermalSensor(
            foreground=colors[4],
            background=colors[0],
            threshold=90,
            fmt='󰏈   {}',
            padding=5,
            decorations=[
                BorderDecoration(
                    colour=colors[4],
                    border_width=[0, 0, 2, 0],
                    padding_x=5,
                    padding_y=None,
                )
            ],
        ),
        widget.Spacer(length = 8),
        widget.TextBox(
            text="󱩵   {:.1f}GB / {:.1f}GB".format(
                # Used disk space in GB
                psutil.disk_usage('/').used / 1024 ** 3,
                # Total disk space in GB
                psutil.disk_usage('/').total / 1024 ** 3,
            ),
            foreground=colors[8],
            background=colors[0],
            decorations=[
                BorderDecoration(
                    colour=colors[8],
                    border_width=[0, 0, 2, 0],
                )
            ],
        ),
        widget.Spacer(length = 8),
        widget.Memory(
            foreground=colors[9],
            background=colors[0],
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn(
                    myTerm + ' -e htop'
                )
            },
            fmt='󰍛 {}',
            padding=5,
            decorations=[
                BorderDecoration(
                    colour=colors[9],
                    border_width=[0, 0, 2, 0],
                    padding_x=5,
                    padding_y=None,
                )
            ],
        ),
        widget.Spacer(length = 8),
        widget.Volume(
            foreground=colors[3],
            background=colors[0],
            fmt='   {}',
            padding=5,
            decorations=[
                BorderDecoration(
                    colour=colors[3],
                    border_width=[0, 0, 2, 0],
                )
            ],
        ),
        widget.Spacer(length = 8),
        widget.KeyboardLayout(
            foreground=colors[8],
            background=colors[0],
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn("setxkbmap us dvorak"),
                'Button3': lambda: qtile.cmd_spawn("setxkbmap us")
            },
            fmt='󰌌  {}',
            padding=5,
            decorations=[
                BorderDecoration(
                    colour=colors[8],
                    border_width=[0, 0, 2, 0],
                )
            ],
        ),
        widget.Spacer(length = 8),
        widget.Systray(
            background=colors[0],
            padding=6,
            icon_size=24,
        ),
        widget.Spacer(length = 8),
    ]
    return widgets_list


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1


def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2[:-5]


def init_screens():
    return [
        Screen(
            top=bar.Bar(
                widgets=init_widgets_screen1(),
                opacity=1.0,
                size=28
            )
        ),
        Screen(
            top=bar.Bar(
                widgets=init_widgets_screen2(),
                opacity=1.0,
                size=28)
        ),
    ]


if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(
    border_focus=colors[10],
    border_width=2,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),   # gitk
        Match(wm_class="dialog"),         # dialog boxes
        Match(wm_class="download"),       # downloads
        Match(wm_class="error"),          # error msgs
        Match(wm_class="file_progress"),  # file progress boxes
        Match(wm_class="makebranch"),     # gitk
        Match(wm_class="maketag"),        # gitk
        Match(wm_class="notification"),   # notifications
        Match(wm_class='pinentry-gtk-2'), # GPG key password entry
        Match(wm_class="ssh-askpass"),    # ssh-askpass
        Match(wm_class="toolbar"),        # toolbars
        Match(wm_class="Yad"),            # yad boxes
        Match(title="branchdialog"),      # gitk
        Match(title='Confirmation'),      # tastyworks exit box
        Match(title='Qalculate!'),        # qalculate-gtk
        Match(title="pinentry"),          # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
