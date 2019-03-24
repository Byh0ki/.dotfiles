#!/bin/bash

## Variables declarations

max_vol="100"

## Functions declarations

usage()
{
    echo -e "./$(basename $0) [up | down | mute] [volume modifier]"
}

getdefaultsinkname()
{
    pacmd stat | awk -F": " '/^Default sink name: /{print $2}'
}

getdefaultsinkvol()
{
    pacmd list-sinks |
        awk '/^\s+name: /{indefault = $2 == "<'$(getdefaultsinkname)'>"}
            /^\s+volume: / && indefault {print $5; exit}'
}

## Script

case "$1" in
    up)
        pactl set-sink-mute @DEFAULT_SINK@ 0
        cur_vol="$(getdefaultsinkvol | tr -d '%')"
        if [ "$cur_vol" -lt "$max_vol" ]; then
            pactl set-sink-volume @DEFAULT_SINK@ +"$2"%
        fi
    ;;
    down)
        pactl set-sink-mute @DEFAULT_SINK@ 0
        pactl set-sink-volume @DEFAULT_SINK@ -"$2"%
    ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
    ;;
    *)
        echo "Unknown command: $1"
        usage
        exit 1
    ;;
esac
exit 0
