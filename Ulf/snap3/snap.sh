#!/usr/bin/env bash

: "${SNAP_SCREENSHOT_DIR:=$HOME/pix/screenshots}"

timestamp="$(date +'%Y-%m-%d-%H:%M:%S')"
tempfile="/tmp/snap"

menuposition="
  --orientation vertical
  --width 333
  --xpos -20
  --ypos 30
"

main() {
  actions=(
    "screenshot - fullscreen"
    "screenshot - selection"
    "screenshot - fullscreen (no cursor)"
  )

  mainaction="${1:-$(actionmenu)}"
     
  case "$mainaction" in

    "screenshot - fullscreen" ) 
      maim --quiet "$tempfile" 
    ;;

    "screenshot - selection" )
      maim --select --hidecursor --quiet "$tempfile" 
    ;;

    "screenshot - fullscreen (no cursor)" )
      maim --hidecursor --quiet "$tempfile" 
    ;;

    * ) cancel ;;

  esac

  preview

  

}

postview() {
  actions=(
    "save"
    "new"
    "re-preview"
    "ulf"
    "ulf and save"
  )

  action="$(actionmenu)"
     
  case "$action" in
    "save" ) savesnap ;;
    "new" ) "${0}" "$mainaction" ;;
    "re-preview" ) preview ;;
    "ulf" ) ulf "$tempfile" ;;
    "ulf and save" )
      ulf "$tempfile" &
      savesnap
    ;;
    * ) cancel ;;

  esac
}

preview() {

  local previewid

  [[ -n ${previewid:=$(i3get --instance snappreview)} ]] \
    && i3-msg -q "[con_id=$previewid]" kill

  i3-msg -q "[con_id=$(i3get --synk --instance snappreview)]" focus &

  sxiv -N snappreview "$tempfile"
  postview
}

cancel() {
  ERR -e "no action selected, aborting"
}

savesnap() {

  target="$(i3menu ${menuposition} \
    --prompt "'save file: '" \
    --filter "${SNAP_SCREENSHOT_DIR/$HOME/'~'}" \
    --include pe
  )"

  target="${target/'~'/$HOME}"

  if [[ -z $target ]]; then
    target="$SNAP_SCREENSHOT_DIR/$timestamp"
  elif [[ -d $target ]]; then
    target="$target/$timestamp"
  elif [[ ! $target =~ ^/ ]]; then
    target="$SNAP_SCREENSHOT_DIR/$target"
  fi

  target="${target%.png}.png"

  mkdir -p "${target%/*}"
  cp -f "$tempfile" "${target}"

  ERR -s "$(printf '%s\n' "*SNAP*" "that goes into:" "${target/$HOME/'~'}")"
}

actionmenu() {
  printf '%s\n' "${actions[@]}" | i3menu ${menuposition} --include l
}

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

pids="$(pgrep -f "bash $0")"
pids="${pids/$$/}"

[[ -n $pids ]] && kill ${pids}

main "${@}"
