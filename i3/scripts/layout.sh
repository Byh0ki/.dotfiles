#!/bin/sh

layout=$(setxkbmap -query | grep "layout:" | tr -s ' ' | cut -d ' ' -f2)

case "$layout" in
    "fr")
      echo "Switching to us qwerty layout.."
      setxkbmap us
      ;;
    "us")
      echo "Switching to fr azerty layout.."
      setxkbmap fr
      ;;
esac
