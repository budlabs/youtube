#!/usr/bin/env bash

i3got=($(i3get --print dit))

wid="${i3got[0]}"
instance="${i3got[1]}"
title="${i3got[@]:2}"
path="${title% -*}"
oldrule="${instance#*-}"

action="$1"
arg="$2"

case "$action" in

  ( toggle-layout )
    [[ $oldrule =~ i ]] \
      && newrule="${oldrule/i/l}" \
      || newrule="${oldrule/l/i}"
  ;;

  ( toggle-order )
    [[ $oldrule =~ a ]] \
      && newrule="${oldrule/a/d}" \
      || newrule="${oldrule/d/a}"
  ;;

  ( toggle-sort )
    if [[ $oldrule =~ t ]];then
      newrule="${oldrule/t/n}"
    elif [[ $oldrule =~ s ]];then
      newrule="${oldrule/s/n}"
    elif [[ $oldrule =~ n ]];then
      newrule="${oldrule/n/t}"
    fi
  ;;

  ( save-layout )
    notify-send "updated dir-rules"
    parserules "$path" "$oldrule"
  ;;

esac



[[ $action != save-layout ]] \
  && updatefm -i "$instance" -d "$wid" -r "$newrule"
