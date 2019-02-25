#!/bin/bash
x=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,' )
let "vol=100 - $1"
if [[ $x -le $vol ]]; then
    $psst pactl set-sink-volume @DEFAULT_SINK@ +$1% && pactl set-sink-mute @DEFAULT_SINK@ 0 $update
fi
