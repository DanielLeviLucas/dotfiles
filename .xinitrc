#!/bin/sh
export QT_QPA_PLATFORMTHEME=qt5ct:qt6ct

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
exec qtile start
