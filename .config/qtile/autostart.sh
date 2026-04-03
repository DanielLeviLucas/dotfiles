#!/usr/bin/env bash 
picom &
conky -c $HOME/.config/conky/qtile/dracula_theme.conkyrc &
dunst &
feh --bg-scale "$HOME/Wallpapers/Itachi Uchiha Dark Raven.jpg" &
copyq &
setxkbmap us dvorak &
xset -dpms &
xset s off &
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources &
