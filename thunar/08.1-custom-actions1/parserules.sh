#!/usr/bin/env bash

# match first argument against DIR-PATTERN
# print rules and exit on match

: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${THUNAR_DIR_RULES_FILE:="$XDG_CONFIG_HOME/Thunar/dir-rules"}"

targetdir="${1/$HOME/'~'}"

[[ -f ${THUNAR_DIR_RULES_FILE} ]] || {
  echo "file doesn't exist"
  echo ". ln" > "${THUNAR_DIR_RULES_FILE}"
}

awk -v srch="${targetdir:-X}" '
  /./ && /^[^#]/ && srch ~ $1"$" {print $2; exit}
' "$THUNAR_DIR_RULES_FILE"
