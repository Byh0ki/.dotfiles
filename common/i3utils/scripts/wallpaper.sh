#!/bin/sh

if [ ! -z "$1" ]; then
    dir="$1"
elif [ ! -z "$WALLPAPERS_PATH" ]; then
    dir="$WALLPAPERS_PATH"
else
    dir="~/.config/wallpapers"
fi

files=$(ls $dir)
printf "%s\n" "${files[RANDOM % ${#files[@]}]}"
