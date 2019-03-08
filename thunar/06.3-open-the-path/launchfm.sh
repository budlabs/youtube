#!/usr/bin/env bash

# Thunar -- classname
# thunar -- instancename
# PATH - File Manager --- title

: "${LAUNCHFM_DEFAULT_CONTAINER:=D}"
: "${LAUNCHFM_SECONDARY_CONTAINER:=B}"
: "${LAUNCHFM_TARGET_CONTAINER:=$LAUNCHFM_DEFAULT_CONTAINER}"
: "${LAUNCHFM_DEFAULT_DIRECTORY:=$HOME}"
: "${LAUNCHFM_TARGET_DIRECTORY:=$LAUNCHFM_DEFAULT_DIRECTORY}"

while getopts :c:p: anything; do
  case "$anything" in
    c ) LAUNCHFM_TARGET_CONTAINER="${OPTARG^^}" ;;
    p ) LAUNCHFM_TARGET_DIRECTORY="${OPTARG}" ;;
  esac
done

LAUNCHFM_TARGET_DIRECTORY="$(
  printf '%q' "${LAUNCHFM_TARGET_DIRECTORY/'~'/$HOME}"
)"

echo "target container: $LAUNCHFM_TARGET_CONTAINER"

containerid="$(i3get \
  --class "Thunar$LAUNCHFM_TARGET_CONTAINER" \
  --title "$LAUNCHFM_TARGET_DIRECTORY - File Manager"
)"

if [[ -n $containerid ]];then

  i3run \
    --conid "$containerid" \
    --nohide \
    --summon \

else
  if [[ $LAUNCHFM_TARGET_CONTAINER != "$LAUNCHFM_SECONDARY_CONTAINER" ]];then
    LAUNCHFM_TARGET_CONTAINER=$LAUNCHFM_DEFAULT_CONTAINER
    rule="$(parserules "${LAUNCHFM_TARGET_DIRECTORY}")"
  else
    rule=l
  fi

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

  # i3run \
  #   --class "Thunar${targetcontainer}" \
  #   --rename '^Thunar$' \
  #   --nohide \
  #   --summon \
  #   --command thunar
fi

exit


if [[ $targetcontainer != B ]];then
  targetcontainer=D
  rule="$(parserules "${path:=$HOME}")"
else
  rule=l
fi

case "$rule" in

  i )
    xfconf-query --channel thunar --property /last-view --create --type string --set ThunarIconView
  ;;

  l )
    xfconf-query --channel thunar --property /last-view --create --type string --set ThunarDetailsView
  ;;

esac



i3run \
  --class "Thunar${targetcontainer}" \
  --rename '^Thunar$' \
  --nohide \
  --summon \
  --command thunar


  # i ) #icon view
  #     xfconf-query --channel thunar --property \
  #       /last-view --set ThunarIconView ;;

  # l ) # list view
  #     xfconf-query --channel thunar --property \
  #       /last-view --set ThunarDetailsView ;;
