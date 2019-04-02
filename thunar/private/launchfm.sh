#!/usr/bin/env bash

# Dependencies:
# parserules, i3get, i3run, i3viswiz, xconf-query, favfm

# ENVIRONMENT variables:
: "${LAUNCHFM_DEFAULT_CONTAINER:=D}"
: "${LAUNCHFM_SECONDARY_CONTAINER:=B}"
: "${LAUNCHFM_SECONDARY_CONTAINER_RULE:=lna}"
: "${LAUNCHFM_DEFAULT_DIRECTORY:=$HOME}"

# global variables
__trgcon=$LAUNCHFM_DEFAULT_CONTAINER  # target container
__trgclass=""                         # target class      
__trgdir=""                           # target directory      
__collumnstoshow=3                    # number of columns to show

# __collumns: collumn order and width of all collumns
__collumns=(
  NAME:235
  DATE_MODIFIED:93
  SIZE:50
  MIME_TYPE:67
  PERMISSIONS:50
  OWNER:50
  DATE_ACCESSED:235
  TYPE:50
  GROUP:125
)

launchthunar() {

    local rule windowid ca c cn cw ws cs i

    if [[ $__trgcon = "$LAUNCHFM_SECONDARY_CONTAINER" ]];then
      # always spawn secondary container with the same layout
      rule="$LAUNCHFM_SECONDARY_CONTAINER_RULE"
    else
      # otherwise determine rule with parserules script
      rule="$(parserules "${__trgdir}")"
    fi

    ws="DATE_ACCESSED,DATE_MODIFIED,PERMISSIONS,MIME_TYPE,NAME,OWNER,GROUP,SIZE,TYPE"

    # parse the __collumns array to set size and order
    # of collumns
    for ((ca=0;ca<${#__collumns[@]};ca++)); do
      c="${__collumns[$ca]}"  # curren collumn
      cn="${c%:*}"         # column name
      cw="${c#*:}"         # column width
      ws="${ws/$cn/$cw}"   # replace column name with width in width string
      ((ca<__collumnstoshow)) \
        && cs+="THUNAR_COLUMN_${cn}," # cs, list of visible columns
    done

    # default thunar settings for new windows
    # xcq(PROP VAL) is a wrapper for xconf-query
    xcq last-details-view-column-widths    "$ws"
    xcq last-details-view-visible-columns  "${cs%,}"
    xcq last-details-view-column-order     "${cs%,}"

    # loop each character in the rule string
    for ((i=0;i<${#rule};i++)); do 
      # rule specific settings
      case "${rule:$i:1}" in
        a ) xcq last-sort-order   "GTK_SORT_ASCENDING"          ;;
        d ) xcq last-sort-order   "GTK_SORT_DESCENDING"         ;;
        t ) xcq last-sort-column  "THUNAR_COLUMN_DATE_MODIFIED" ;;
        n ) xcq last-sort-column  "THUNAR_COLUMN_NAME"          ;;
        s ) xcq last-sort-column  "THUNAR_COLUMN_SIZE"          ;;
        i ) xcq last-view         "ThunarIconView"              ;;
        l ) xcq last-view         "ThunarDetailsView"           ;;
      esac
    done

    # start thunar with trgdir in the background
    thunar "${__trgdir}" &

    # --synk to wait for the window to exist
    # --print d will print the windowid
    windowid="$(i3get --synk                              \
                      --class 'Thunar$'                   \
                      --title "$__trgdir - File Manager"  \
                      --print d
               )"

    # rename both the instance and class name of
    # the new window. matching for_window rules
    # in the i3config will move the new window to 
    # the right container.
    xdotool set_window --class "$__trgclass"      \
                       --classname "thunar-$rule" \
                       "$windowid"                \

    

}

main() {

  local containerid

  while getopts :c:p: option; do
    case "$option" in
      c ) __trgcon="${OPTARG^^}" ;;
      p ) __trgdir="${OPTARG}"   ;;
      * ) break ;;
    esac
  done

  __trgclass="Thunar$__trgcon"

  if [[ -z $__trgdir ]]; then
    # no path specified, try to target guess window
    containerid="$(i3viswiz --class "$__trgclass")"

    if [[ -z $containerid ]]; then
      # no visible windows
      containerid="$(i3get --class "$__trgclass")"

      if [[ -z $containerid ]]; then
        # no existing window in target container,
        # set the default directory as trgdir and
        # spawn a new window
        __trgdir="$(escapechars "$LAUNCHFM_DEFAULT_DIRECTORY")"
        launchthunar

      else
        # thunar window exist in target container 
        # but is not visible
        focusthunar "$containerid" 
      fi
    else
      # found visible window
      focusthunar "$containerid" 
    fi
  else
    # trg dir is konwn
    __trgdir="$(escapechars "$__trgdir")"
    containerid="$(i3get --title "$__trgdir - File Manager" \
                         --class "$__trgclass"               
                  )"

    if [[ -n $containerid ]];then
      # a matching window exist
      focusthunar "$containerid" 
    else
      # no found match, launchthunar
      launchthunar
    fi

    # add directory to history
    favfm "${__trgdir}"

  fi
}

focusthunar() { i3run --conid "$1" --nohide --summon ;}
escapechars() { printf '%q' "${1/'~'/$HOME}" ;}
xcq() {

  local prop="$1" val="$2" type=""

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
