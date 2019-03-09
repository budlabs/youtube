#!/usr/bin/env bash



while getopts :i:d:p: anything; do
  case "$anything" in
    i ) instance="${OPTARG}" ;;
    d ) windowid="${OPTARG}" ;;
    p ) path="${OPTARG}" ;;
  esac
done

echo "the current instance name is $instance"

rule="$(parserules "$path")"

if [[ $rule = "${instance#*-}" ]]; then
  echo layout already applied
else
  echo apply new layout
  case "$rule" in

    i ) 
      xdotool key --window "$windowid" "ctrl+1" set_window --classname "thunar-$rule" "$windowid"
      # thunar-i
      echo updated to icon view
    ;;

    l ) 
      xdotool key --window "$windowid" "ctrl+2" set_window --classname "thunar-$rule" "$windowid"
      # thunar-l
      echo updated to list view
    ;;

    * ) echo default  ;;
  esac
fi




# set_window [options] [windowid=%1]
#            Set properties about a window. If no window is given, %1 is the
#            default. See "WINDOW STACK" and "COMMAND CHAINING" for more details.

#            Options:

#            --name newname
#                Set window WM_NAME (the window title, usually)

#            --icon-name newiconname
#                Set window WM_ICON_NAME (the window title when minimized, usually)

#            --role newrole
#                Set window WM_WINDOW_ROLE

#            --classname newclassname
#                Set window class name (not to be confused with window class)

#            --class newclass
#                Set window class (not to be confused with window class name)
