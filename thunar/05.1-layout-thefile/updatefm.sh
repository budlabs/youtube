#!/usr/bin/env bash

# compare $1 (the path)
# against file
# if file doesn't exist
# create it

: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${THUNAR_DIR_RULES_FILE:="$XDG_CONFIG_HOME/Thunar/dir-rules"}"

# echo this is from  hhhh update "$1"

[[ -f ${THUNAR_DIR_RULES_FILE} ]] || {
  echo "file doesn't exist"
  echo ". l" > "${THUNAR_DIR_RULES_FILE}"
}

# cat "$THUNAR_DIR_RULES_FILE"
