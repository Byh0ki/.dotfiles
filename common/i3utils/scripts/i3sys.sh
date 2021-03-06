#!/usr/bin/env bash

# If you want to lock before sleep, please check the README.MD

lock_script="$HOME/.config/i3utils/i3lock/lock_vanilla.sh"

pause()
{
    killall -SIGUSR1 dunst # pause
    # killall compton
}

resume()
{
    killall -SIGUSR2 dunst # resume
    # compton -b
}

lock()
{
    pause
    $lock_script
    resume
}

# This function is only usefull if your i3lock is called without the '-n'
# option which make i3lock a blocking call
sleeep()
{
    pause
    $lock_script
    sleep 1
    if [ "$1" = "hibernate" ]; then
        systemctl hibernate
    else
        systemctl suspend
    fi
    sleep 1
    resume
}

# No arg -> lock
if [ -z "$1" ]; then
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
            systemctl suspend
            ;;
        hibernate)
            systemctl hibernate
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
