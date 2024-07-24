#!/usr/bin/env bash 
picom &
conky -c $HOME/.config/conky/qtile/dracula_theme.conkyrc &
dunst &
nitrogen --restore &
copyq &
setxkbmap us dvorak &
xset -dpms &
xset s off &
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources &
