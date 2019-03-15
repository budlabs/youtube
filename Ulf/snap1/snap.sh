#!/usr/bin/env bash

tempfile="/tmp/snap"

main() {
  actions=(
    "screenshot - fullscreen"
    "screenshot - selection"
    "screenshot - fullscreen (no cursor)"
  )

  action="$(printf '%s\n' "${actions[@]}" | \
    i3menu \
      --orientation vertical \
      --width 333 \
      --xpos -20 \
      --ypos 30 \
      --include l
  )"
     
  case "$action" in

    "screenshot - fullscreen" ) 
      maim --quiet "$tempfile" 
    ;;

    "screenshot - selection" )
      maim --select --hidecursor --quiet "$tempfile" 
    ;;

    "screenshot - fullscreen (no cursor)" )
      maim --hidecursor --quiet "$tempfile" 
    ;;

    * ) 

      ERR -e "no action selected, aborting"
    ;;

  esac

  {
    xdotool search --sync --classname snappreview 
    notify-send "found sxiv"
    i3-msg "[instance=snappreview]" focus
  } &

  sleep 2

  sxiv -N snappreview "$tempfile"


  notify-send "sxiv closed"
}







 # maim --select --hidecursor  --quiet /tmp/snap 
# bindsym Mod4+Shift+c exec --no-startup-id snap

# 1. display actions menu
# 2. actions are different ways to capture (shot, cast, audio)
# 3. perform action
# 4. preview result (sxiv/mpv)
# 5. when preview is closed, new action menu
# 6. save, ulf, save+ulf, preview, new, (edit)
# 7. execute selected action

# define menu geometry (save in var)
# store path to temp file in variable
# add ERR function, create main function
# maim

# maim \
#   --delay 3 \
#   --select \
#   --hidecursor \
#   --quiet \
#   FILE





ERR() {

  # synopsis
  # --------
  
  # ERR -e MSG...
  # create a error message, red highlight, and 
  # exit current script with exit code 1
  # notify-send will get executed with urgency-level
  # critical.

  # ERR -w MSG...
  # create a warning message, yellow highlight

  # ERR -s MSG...
  # create a success message, green highlight, and 
  # notify-send will get executed with urgency-level
  # low.

  # ERR -m MSG...
  # ERR MSG...
  # just print MSG to stderr or notify-send, without
  # any special formatting or options.


  local RED GREEN YELLOW NORMAL

  RED=$(tput setaf 1)
  GREEN=$(tput setaf 2)
  YELLOW=$(tput setaf 3)
  NORMAL=$(tput sgr0)

  case "$1" in

    -w )
      shift

      if [[ -t 2 ]]; then
        (>&2 echo "[${YELLOW}WARNING${NORMAL}]" "$*")
      else
        notify-send "[WARNING] $*"
      fi

    ;;

    -s )
      shift

      if [[ -t 2 ]]; then
        (>&2 echo "[${GREEN}SUCCESS${NORMAL}]" "$*")
      else
        notify-send -u low "[SUCCESS] $*"
      fi
    ;;

    -e )
      shift

      if [[ -t 2 ]]; then
        (>&2 echo "[${RED}ERROR${NORMAL}]" "$*")
      else
        notify-send -u critical "[ERROR] $*"
      fi

      exit 1
    ;;

    -m )
      shift

      if [[ -t 2 ]]; then
        (>&2 echo "$*")
      else
        notify-send "$*"
      fi
    ;;

    *  )

      if [[ -t 2 ]]; then
        (>&2 echo "$*")
      else
        notify-send "$*"
      fi
    ;;

  esac
}

main "${@}"
