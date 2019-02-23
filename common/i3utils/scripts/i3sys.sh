#!/usr/bin/env bash

lock()
{
    killall -SIGUSR1 dunst # pause
    killall compton
    $HOME/.config/i3utils/i3lock/lock_vanilla.sh
    compton -b
    killall -SIGUSR2 dunst # resume
}

if [ -z $1 ]; then
    lock
else
    case "$1" in
        lock)
            lock
            ;;
        logout)
            i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3?' -b 'Yes, exit i3' 'i3-msg exit'
            ;;
        suspend)
            lock && sleep 1 && systemctl suspend
            ;;
        hibernate)
            lock && sleep 1 && systemctl hibernate
            ;;
        reboot)
            i3-nagbar -t warning -m 'You pressed the reboot shortcut. Do you really want to reboot ?' -b 'Yes, reboot' 'systemctl reboot'
            ;;
        shutdown)
            i3-nagbar -t warning -m 'You pressed the poweroff shortcut. Do you really want to poweroff ?' -b 'Yes, poweroff' 'systemctl poweroff -i'
            ;;
        *)
            echo "Usage: $0 [lock|logout|suspend|hibernate|reboot|shutdown]"
            exit 2
    esac
fi

exit 0
