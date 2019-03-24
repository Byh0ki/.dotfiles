#!/bin/bash

## Variables declarations

max_vol="100"
expire=1500

## Functions declarations

usage()
{
    echo -e "./$(basename "$0") [up | down | mute] [volume modifier]"
}

getdefaultsinkname()
{
    pacmd stat | awk -F": " '/^Default sink name: /{print $2}'
}

getdefaultsinkvol()
{
    if [ -n "$1" ]; then
        sink="$1"
    else
        sink="$(getdefaultsinkname)"
    fi
    pacmd list-sinks |
        awk '/^\s+name: /{indefault = $2 == "<'"$sink"'>"}
            /^\s+volume: / && indefault {gsub("%", ""); print $5; exit}'
}

is_muted()
{
    if [ -n "$1" ]; then
        sink="$1"
    else
        sink="$(getdefaultsinkname)"
    fi
    muted="$(pacmd list-sinks |
            awk '/^\s+name: /{indefault = $2 == "<'"$sink"'>"}
                /^\s+muted: / && indefault {print $2; exit}')"
    [ "$muted" = "yes" ]
}

dunstify_available()
{
    command -v dunstify > /dev/null
}

get_volume_icon() {
    local vol="$1"
    local icon

    if [ "$vol" -ge 70 ]; then icon="audio-volume-high"
    elif [ "$vol" -ge 40 ]; then icon="audio-volume-medium"
    elif [ "$vol" -gt 0 ]; then icon="audio-volume-low"
    else icon="audio-volume-low"
    fi

    echo "${icon}"
}

# Generates a progress bar for the provided value.
#
# Arguments:
#   Percentage      (integer) Percentage of progress.
#   Maximum         (integer) Maximum percentage. (default: 100)
#   Divisor         (integer) For calculating the ratio of blocks to progress (default: 5)
#
# Returns:
#   The progress bar.
get_progress_bar() {
    local percent="$1"
    local max_percent=${2:-100}
    local divisor=${3:-5}
    local progress=$(((percent > max_percent ? max_percent : percent) / divisor))

    printf '█%.0s' $(eval echo "{1..$progress}")
}

# Display a notification indicating the volume is muted.
notify_muted() {
    if dunstify_available; then
        dunstify -i audio-volume-muted -t "$expire" -h int:value:0 -h string:synchronous:volume "Volume muted" -r 1000
    else
        notify-send -i audio-volume-muted -t "$expire" -h int:value:0 -h string:synchronous:volume "Volume muted"
    fi
}

# Display a notification indicating the current volume.
notify_volume() {
    if [ -n "$1" ]; then
        sink="$1"
    else
        sink="$(getdefaultsinkname)"
    fi
    local vol="$(getdefaultsinkvol "$sink")"
    local icon="$(get_volume_icon "$vol")"
    local text="Volume ${vol}% $(get_progress_bar "$vol")"

    if dunstify_available; then
        dunstify -i "$icon" -t "$expire" -h int:value:"$vol" -h string:synchronous:volume "$text" -r 1000
    else
        notify-send -i "$icon" -t "$expire" -h int:value:"$vol" -h string:synchronous:volume "$text"
    fi
}

## Script

default_sink_name="$(getdefaultsinkname)"
if [ -n "$2" ]; then
    if [ "$2" -eq "$2" ] 2>/dev/null; then
        vol_mod="$2"
    else
        echo "You must provide a valid integer."
        exit 3
    fi
else
    vol_mod="2"
fi

case "$1" in
    up)
        pactl set-sink-mute @DEFAULT_SINK@ 0
        cur_vol="$(getdefaultsinkvol "$default_sink_name")"
        ((new_vol="$cur_vol" + "$vol_mod"))
        if [ "$new_vol" -le "$max_vol" ]; then
            pactl set-sink-volume @DEFAULT_SINK@ +"$vol_mod"%
        else
            ((new_vol_mod="$max_vol" - "$cur_vol"))
            if [ "$new_vol_mod" -gt 0 ]; then
                pactl set-sink-volume @DEFAULT_SINK@ +"$new_vol_mod"%
            fi
        fi
    ;;
    down)
        pactl set-sink-mute @DEFAULT_SINK@ 0
        pactl set-sink-volume @DEFAULT_SINK@ -"$vol_mod"%
    ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
    ;;
    *)
        echo "Unknown command: $1"
        usage
        exit 2
    ;;
esac

if is_muted "$default_sink_name"; then
    notify_muted
else
    notify_volume "$default_sink_name"
fi

exit 0
