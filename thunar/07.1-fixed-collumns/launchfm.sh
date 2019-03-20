#!/usr/bin/env bash

# Thunar -- classname
# thunar -- instancename
# PATH - File Manager --- title

: "${LAUNCHFM_DEFAULT_CONTAINER:=D}"
: "${LAUNCHFM_SECONDARY_CONTAINER:=B}"
: "${LAUNCHFM_TARGET_CONTAINER:=$LAUNCHFM_DEFAULT_CONTAINER}"
: "${LAUNCHFM_DEFAULT_DIRECTORY:=$HOME}"

main() {

  while getopts :c:p: anything; do
    case "$anything" in
      c ) LAUNCHFM_TARGET_CONTAINER="${OPTARG^^}" ;;
      p ) LAUNCHFM_TARGET_DIRECTORY="${OPTARG}" ;;
    esac
  done

  if [[ -z $LAUNCHFM_TARGET_DIRECTORY ]]; then

    echo no path specified, using AI

    containerid="$(i3viswiz --class "Thunar$LAUNCHFM_TARGET_CONTAINER")"

    if [[ -z $containerid ]]; then
      echo no visible thunar window

      containerid="$(i3get --class "Thunar$LAUNCHFM_TARGET_CONTAINER")"

      if [[ -z $containerid ]]; then

        echo no such window exist

        LAUNCHFM_TARGET_DIRECTORY="$(escapechars "$LAUNCHFM_DEFAULT_DIRECTORY")"
        launchthunar

      else
        echo there at least exist a window but it is not visible
        focusthunar "$containerid" 
      fi

    else
      echo found a visible window in "$LAUNCHFM_TARGET_CONTAINER" container
      focusthunar "$containerid" 
    fi
  else

    echo target directory is known

    LAUNCHFM_TARGET_DIRECTORY="$(escapechars "$LAUNCHFM_TARGET_DIRECTORY")"

    echo "target container: $LAUNCHFM_TARGET_CONTAINER"

    containerid="$(i3get \
      --class "Thunar$LAUNCHFM_TARGET_CONTAINER" \
      --title "$LAUNCHFM_TARGET_DIRECTORY - File Manager"
    )"

    if [[ -n $containerid ]];then

      focusthunar "$containerid" 

    else

      launchthunar

    fi

  fi
}

escapechars() {
  printf '%q' "${1/'~'/$HOME}"
}

focusthunar() {

  local conid="$1"

  i3run \
    --conid "$conid" \
    --nohide \
    --summon

}

launchthunar() {

    local rule

    if [[ $LAUNCHFM_TARGET_CONTAINER != "$LAUNCHFM_SECONDARY_CONTAINER" ]];then
      LAUNCHFM_TARGET_CONTAINER=$LAUNCHFM_DEFAULT_CONTAINER
      rule="$(parserules "${LAUNCHFM_TARGET_DIRECTORY}")"
    else
      rule=l
    fi

    xfconf-query --channel thunar --property /last-details-view-column-widths --create --type string --set 50,93,50,50,235,50,50,67,125
    xfconf-query --channel thunar --property /last-details-view-visible-columns --create --type string --set THUNAR_COLUMN_DATE_MODIFIED,THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE
    xfconf-query --channel thunar --property /last-details-view-column-order --create --type string --set THUNAR_COLUMN_NAME,THUNAR_COLUMN_DATE_MODIFIED,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_TYPE,THUNAR_COLUMN_DATE_ACCESSED,THUNAR_COLUMN_OWNER,THUNAR_COLUMN_PERMISSIONS,THUNAR_COLUMN_MIME_TYPE,THUNAR_COLUMN_GROUP

    case "$rule" in

      i )
        xfconf-query --channel thunar --property /last-view --create --type string --set ThunarIconView
      ;;

      l )
        xfconf-query --channel thunar --property /last-view --create --type string --set ThunarDetailsView
      ;;

    esac

    thunar "${LAUNCHFM_TARGET_DIRECTORY}" &

    windowid="$(i3get \
      --class 'Thunar$' \
      --title "$LAUNCHFM_TARGET_DIRECTORY - File Manager" \
      --synk \
      --print d
    )"


    xdotool \
      set_window \
        --classname "thunar-$rule" \
        --class     "Thunar$LAUNCHFM_TARGET_CONTAINER" \
        "$windowid"

}


main "${@}"
