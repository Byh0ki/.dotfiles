#!/bin/sh

# find . -type f | grep -E "([^\\s]+(jpg|png|bmp))"
# find . -type f -exec file {} \; | awk -F: '{if ($2 ~/image/) print $1}'


rand ()
{
  declare -a array=("$@")
  r=$((RANDOM % ${#array[@]}))
  printf "%s\n" "${array[$r]}"
}

if [ ! -z "$1" ]; then
    dir="$1"
elif [ ! -z "$WALLPAPERS_PATH" ]; then
    dir="$WALLPAPERS_PATH"
else
    dir="$HOME/.config/wallpapers"
fi

img="$(find -L "$dir" -type f | grep -E "([^\\s]+(jpg|png|bmp))")"
wall="$(rand $img)"

feh --bg-fill $wall
