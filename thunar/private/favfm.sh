#!/usr/bin/env bash

# --MODE history, bookmark, both(default)

# ENVIRONMENT variables:
: "${LAUNCHFM_DEFAULT_CONTAINER:=D}"
: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${THUNAR_HISTORY:="$XDG_CONFIG_HOME/Thunar/history"}"
: "${THUNAR_BOOKMARKS:="$XDG_CONFIG_HOME/Thunar/bookmarks"}"

main() {
  if [[ -d "${1/'~'/$HOME}" ]]; then
    updatehistory "$1"
  else
    trgcon="${1:-$LAUNCHFM_DEFAULT_CONTAINER}"

    dest="$(cat "$THUNAR_BOOKMARKS" "$THUNAR_HISTORY" | \
            i3menu --prompt "'GoTo: '" \
                   --layout "$trgcon"  \
                   --top "$(cat "$THUNAR_BOOKMARKS")" \
           )"

    [[ -d ${dest/'~'/$HOME} ]] || exit 1

    launchfm -c "$trgcon" -p "${dest/'~'/$HOME}"
  fi
}

updatehistory() {
  if [[ -f $THUNAR_HISTORY ]]; then 
    awk -i inplace -v dir="${1/$HOME/'~'}" '
      NR==1 {print dir}
      $0 != dir {print}
    ' "$THUNAR_HISTORY"
  else
    echo "${1/$HOME/'~'}" > "$THUNAR_HISTORY"
  fi
}

main "${@}"


