#!/usr/bin/env bash

# compare $1 (the path)
# against file
# if file doesn't exist
# create it

rule="$(parserules "$1")"

case "$rule" in
  i ) xdotool key "ctrl+1" ;;
  l ) xdotool key "ctrl+2" ;;
  * ) echo default  ;;
esac

