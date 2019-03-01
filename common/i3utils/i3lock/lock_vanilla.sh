#!/bin/bash

# This script need scrot and ImageMagick to run properly

icon="$HOME/.config/i3utils/i3lock/icons/lock.png"
tmpbg='/tmp/screen.png'

(( $# )) && { icon=$1; }

scrot "$tmpbg"
convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
i3lock -n -e -i "$tmpbg"
rm "$tmpbg"
