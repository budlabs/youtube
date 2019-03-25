#!/usr/bin/env bash

i3got=($(i3get --print di))

wid="${i3got[0]}"
instance="${i3got[1]}"
oldrule="${instance#*-}"

case "$1" in

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
esac



updatefm -i "$instance" -d "$wid" -r "$newrule"
