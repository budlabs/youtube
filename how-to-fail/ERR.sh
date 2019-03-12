#!/usr/bin/env bash

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

      if [[ -t 1 ]]; then
        (>&2 echo "[${YELLOW}WARNING${NORMAL}]" "$*")
      else
        notify-send "[WARNING] $*"
      fi

    ;;

    -s )
      shift

      if [[ -t 1 ]]; then
        (>&2 echo "[${GREEN}SUCCESS${NORMAL}]" "$*")
      else
        notify-send -u low "[SUCCESS] $*"
      fi
    ;;

    -e )
      shift

      if [[ -t 1 ]]; then
        (>&2 echo "[${RED}ERROR${NORMAL}]" "$*")
      else
        notify-send -u critical "[ERROR] $*"
      fi

      exit 1
    ;;

    -m )
      shift

      if [[ -t 1 ]]; then
        (>&2 echo "$*")
      else
        notify-send "$*"
      fi
    ;;

    *  )

      if [[ -t 1 ]]; then
        (>&2 echo "$*")
      else
        notify-send "$*"
      fi
    ;;

  esac
}
