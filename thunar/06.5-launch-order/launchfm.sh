#!/usr/bin/env bash

# ENVIRONMENT VARIABLES
: "${LAUNCHFM_DEFAULT_CONTAINER:=D}"
: "${LAUNCHFM_SECONDARY_CONTAINER:=B}"
: "${LAUNCHFM_SECONDARY_CONTAINER_RULE:=lna}"
: "${LAUNCHFM_DEFAULT_DIRECTORY:=$HOME}"

# global variables
__trgdir=""                           # target directory
__trgclass=""                         # target class
__trgcon=$LAUNCHFM_DEFAULT_CONTAINER  # target contatiner

__numberofcollumns=3

# order of this array will correspond with the
# order of collumns in thunar. don't remove
# elements. last part of each element is the width
# of the collumn in pixels.
__acols=(
  NAME:235
  DATE_MODIFIED:93
  SIZE:67
  DATE_ACCESSED:69
  PERMISSIONS:69
  MIME_TYPE:59
  OWNER:59
  GROUP:59
  TYPE:59
)

launchthunar() {

    local rule windowid ws ca c cn cw ws cs

    if [[ $__trgcon != "$LAUNCHFM_SECONDARY_CONTAINER" ]];then
      rule="$(parserules "${__trgdir}")"
    else
      rule="$LAUNCHFM_SECONDARY_CONTAINER_RULE"
    fi

    ws="DATE_ACCESSED,DATE_MODIFIED,PERMISSIONS,MIME_TYPE,NAME,OWNER,GROUP,SIZE,TYPE"

    # replacing strings in ws, with the width of a collumn
    # and creating order of collumns depending on the order
    # of element in __acols
    for ((ca=0;ca<${#__acols[@]};ca++)); do
      c="${__acols[$ca]}"
      cn="${c%:*}"
      cw="${c#*:}"
      ws="${ws/$cn/$cw}"
      ((ca<__numberofcollumns)) && cs+="THUNAR_COLUMN_$cn,"
    done

    # xcq is a wrapper for xconf-query(PROP VAL)

    # default settings for new thunar windows
    xcq last-details-view-column-widths    "$ws"
    xcq last-details-view-visible-columns  "${cs%,}"
    xcq last-details-view-column-order     "${cs%,}"

    for ((i=0;i<${#rule};i++)); do

      # rule specific settings:
      case "${rule:$i:1}" in
        a ) xcq last-sort-order   GTK_SORT_ASCENDING          ;;
        d ) xcq last-sort-order   GTK_SORT_DESCENDING         ;;
        t ) xcq last-sort-column  THUNAR_COLUMN_DATE_MODIFIED ;;
        s ) xcq last-sort-column  THUNAR_COLUMN_SIZE          ;;
        n ) xcq last-sort-column  THUNAR_COLUMN_NAME          ;;
        i ) xcq last-view         ThunarIconView              ;;
        l ) xcq last-view         ThunarDetailsView           ;;
      esac

    done

    thunar "${__trgdir}" &

    windowid="$(i3get --synk                             \
                      --class 'Thunar$'                  \
                      --title "$__trgdir - File Manager" \
                      --print d
               )"


    xdotool set_window --classname "thunar-$rule"  \
                       --class     "$__trgclass"   \
                       "$windowid"                 \

}

main() {

  local containerid option

  while getopts :c:p: option; do
    case "$option" in
      c ) __trgcon="${OPTARG^^}" ;;
      p ) __trgdir="${OPTARG}" ;;
    esac
  done

  __trgclass="Thunar$__trgcon"

  if [[ -z $__trgdir ]]; then
    # no path argument, trying to guess target window
    containerid="$(i3viswiz --class "$__trgclass")"

    if [[ -z $containerid ]]; then
      # no visible window in trgcon found
      containerid="$(i3get --class "$__trgclass")"
      if [[ -z $containerid ]]; then
        # no window in trgcont exist, spawn new window
        __trgdir="$(escapechars "$LAUNCHFM_DEFAULT_DIRECTORY")"
        launchthunar
      else
        # a thunar window exist in trgcon, but is
        # not visible, focus it.
        focusthunar "$containerid" 
      fi

    else
      # found a visible thunar window in trgcon, focus
      focusthunar "$containerid" 
    fi
  else
    # a directory is passed to -p
    __trgdir="$(escapechars "$__trgdir")"
    containerid="$(i3get \
      --class "$__trgclass" \
      --title "$__trgdir - File Manager"
    )"

    if [[ -n $containerid ]];then
      focusthunar "$containerid" 
    else
      launchthunar
    fi

  fi
}

escapechars() { printf '%q' "${1/'~'/$HOME}" ;}
focusthunar() { i3run --conid "$1"--nohide --summon ;}

xcq() {

  local prop="$1" val="$2" type

  if [[ $val =~ ^[0-9]+$ ]]; then
    type="int"
  elif [[ $val =~ ^(true|false)$ ]]; then
    type="bool"
  else
    type="string"
  fi

  xfconf-query --create             \
               --channel thunar     \
               --property /"$prop"  \
               --type "$type"       \
               --set "$val"         \

}


main "${@}"
