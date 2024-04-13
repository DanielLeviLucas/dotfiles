#!/usr/bin/env bash 
picom --experimental-backends &
conky -c $HOME/.config/conky/qtile/dracula_theme.conkyrc &
dunst &
nitrogen --restore &
copyq &
setxkbmap us dvorak &
xinput set-prop 13 "libinput Accel Speed" -0.9 &
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources &
