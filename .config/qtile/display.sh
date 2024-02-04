#!/bin/sh
xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-0 --primary --rate 180 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-1 --off

xinput set-prop 10 "libinput Accel Speed" -0.9
