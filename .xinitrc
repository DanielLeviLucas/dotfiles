#!/bin/sh
export QT_QPA_PLATFORMTHEME=qt5ct:qt6ct

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
/usr/lib/pam_kwallet_init &
exec dbus-run-session qtile start
