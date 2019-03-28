#!/usr/bin/env bash

while getopts :i:d:p:r: anything; do
  case "$anything" in
    i ) instance="${OPTARG}" ;;
    d ) windowid="${OPTARG}" ;;
    p ) path="${OPTARG}" ;;
    r ) newrule="${OPTARG}" ;;
  esac
done

echo "the current instance name is $instance"

oldrule="${instance#*-}"
newrule="${newrule:-$(parserules "$path")}"

if [[ $newrule = "$oldrule" ]]; then
  echo layout already applied
else
  echo apply new layout

  echo "old rule: $oldrule"
  echo "new rule: $newrule"

  [[ $oldrule =~ .*(a|d).*   ]] && oldorder="${BASH_REMATCH[1]}"
  [[ $oldrule =~ .*(s|t|n).* ]] && oldsort="${BASH_REMATCH[1]}"
  [[ $oldrule =~ .*(i|l).*   ]] && oldlayout="${BASH_REMATCH[1]}"
  [[ $newrule =~ .*(a|d).*   ]] && neworder="${BASH_REMATCH[1]}"
  [[ $newrule =~ .*(s|t|n).* ]] && newsort="${BASH_REMATCH[1]}"
  [[ $newrule =~ .*(i|l).*   ]] && newlayout="${BASH_REMATCH[1]}"

  combo="ctrl+alt+shift+"

  if [[ $newlayout = i ]] || [[ ${oldsort}${oldorder} != "${newsort}${neworder}" ]]; then
    [[ $oldlayout != i ]] && keys+=("${combo}1")
    [[ $oldorder  != "$neworder" ]] && keys+=("${combo}$neworder")
    [[ $oldsort   != "$newsort"  ]] && keys+=("${combo}$newsort")
  fi

  [[ $newlayout = l ]] && keys+=("${combo}2")

  echo keys to send:
  printf '%s\n' "${keys[@]}"

  xdotool key --delay 8 --window "$windowid" ${keys[*]} \
          set_window --classname "thunar-$newrule" "$windowid"

fi
