#!/bin/bash

if [[ $# -eq 2 ]]; then
  mkdir -p $2
  case "$1" in
    '-u')
      scrot -u '%Y%m%d_%H%M%S.png' -e 'mv $f '"$2"
      ;;
    '-f')
        scrot '%Y%m%d_%H%M%S.png' -e 'mv $f '"$2"
      ;;
    *)
      echo 'Not yet supported.'
      ;;
  esac
  [ "$?" -eq 0 ] && notify-send "Screenshot captured" "Saved in $2"
fi
