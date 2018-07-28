#!/bin/bash

WP_DIR="$HOME/Images/Wallpapers"
WP_CUR="$(gsettings get org.gnome.desktop.background picture-uri)"
WP_NEW="$WP_CUR"

while [ "$WP_CUR" == "$WP_NEW" ]; do
	while read WP; do
		WP_NEW="'$WP_DIR/$WP'"
	done <<<$(ls "$WP_DIR" | sort -R | tail -1)
done

gsettings set org.gnome.desktop.background picture-uri "$WP_NEW"

# in crontab, run it like following:
# DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /bin/bash $HOME/Documents/scripts/wallpaper.sh >/dev/null 2>&1
