#!/bin/sh
xinput set-prop 13 "libinput Accel Speed" -0.9
exec qtile start
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
