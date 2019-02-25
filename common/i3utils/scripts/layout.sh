#!/bin/sh

layout=$(setxkbmap -query | grep "layout:" | tr -s ' ' | cut -d ' ' -f2)

case "$layout" in
    "fr")
        echo "Switching to us qwerty layout.."
        setxkbmap us
        nLayout=us
        ;;
    "us")
        echo "Switching to fr azerty layout.."
        setxkbmap fr
        nLayout=fr
        ;;
    *)
        echo "This must be a conf loose.."
        setxkbmap us
        nLayout=us
esac
[ "$?" -eq 0 ] && notify-send "Keyboard layout" "Switched from '$layout' to '$nLayout'"
