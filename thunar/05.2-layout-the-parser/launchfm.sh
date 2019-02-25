#!/usr/bin/env bash

# Thunar -- classname
# thunar -- instancename
# PATH - File Manager --- title

while getopts :c: anything; do
  case "$anything" in
    c ) targetcontainer="${OPTARG^^}" ;;
  esac
done


[[ $targetcontainer != B ]] && targetcontainer=D
# echo $targetcontainer

i3run \
  --class "Thunar${targetcontainer}" \
  --rename '^Thunar$' \
  --nohide \
  --summon \
  --command thunar
