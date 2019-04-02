#!/usr/bin/env bash

: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${DUNST_LAYOUT_DIR:="$XDG_CONFIG_HOME/dunst/layouts"}"

main() {
  while getopts :d:r:m:u:t: option ; do
    case "$option" in
      d ) __wid="${OPTARG}" ;;
      r ) __did="${OPTARG}" ;;
      m ) __msg="${OPTARG}" ;;
      u ) __urg="${OPTARG}" ;;
      t ) __tim="${OPTARG}" ;;
      * ) break ;;
    esac
  done

  declare -A i3list
  eval "$(i3list ${__wid:+--winid $__wid})"

  sed -e "s/%%width%%/$((i3list[TWW]-10))/"  \
      -e "s/%%xpos%%/$((i3list[TWX]+5))/"    \
      -e "s/%%ypos%%/$((i3list[TWY]+25))/"   \
    "$DUNST_LAYOUT_DIR/flex" \
  > "$DUNST_LAYOUT_DIR/flexgen"

  dunstmerge flexgen

  dunstify --block                       \
           ${__urg:+--urgency $__urg}  \
           ${__did:+--replace $__did}    \
           ${__tim:+--timeout $__tim}    \
           "$__msg"

  rm "$DUNST_LAYOUT_DIR/flexgen"
  dunstmerge

}

main "${@}" > /dev/null 2>&1 &

