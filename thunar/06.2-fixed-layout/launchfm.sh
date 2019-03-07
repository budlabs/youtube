#!/usr/bin/env bash

# Thunar -- classname
# thunar -- instancename
# PATH - File Manager --- title

while getopts :c: anything; do
  case "$anything" in
    c ) targetcontainer="${OPTARG^^}" ;;
  esac
done


if [[ $targetcontainer != B ]];then
  targetcontainer=D
  rule="$(parserules "${path:=$HOME}")"
else
  rule=l
fi

case "$rule" in

  i )
    xfconf-query --channel thunar --property /last-view --create --type string --set ThunarIconView
  ;;

  l )
    xfconf-query --channel thunar --property /last-view --create --type string --set ThunarDetailsView
  ;;

esac



i3run \
  --class "Thunar${targetcontainer}" \
  --rename '^Thunar$' \
  --nohide \
  --summon \
  --command thunar


  # i ) #icon view
  #     xfconf-query --channel thunar --property \
  #       /last-view --set ThunarIconView ;;

  # l ) # list view
  #     xfconf-query --channel thunar --property \
  #       /last-view --set ThunarDetailsView ;;
