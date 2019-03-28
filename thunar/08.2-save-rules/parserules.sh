#!/usr/bin/env bash

# match first argument against DIR-PATTERN
# print rules and exit on match

: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${THUNAR_DIR_RULES_FILE:="$XDG_CONFIG_HOME/Thunar/dir-rules"}"

targetdir="${1/$HOME/'~'}"
targetrule="$2"

[[ -f ${THUNAR_DIR_RULES_FILE} ]] || {
  echo "file doesn't exist"
  echo ". lna" > "${THUNAR_DIR_RULES_FILE}"
}

awk \
  -v trgdir="${targetdir:-X}" \
  -v trgrul="${targetrule:-X}" \
  ${targetrule:+-i inplace} \
'
  /./ && /^[^#]/ && trgdir ~ $1"$" {
    if (trgrul == "X") {
      print $2; exit
    } else if ($1 == ".") {
      if (trgdir != "FOUND") {
        print trgdir "   " trgrul
      }
    } else {
      sub($2,trgrul)
      trgdir="FOUND"
    }
  }

  trgrul != "X" {print}


' "$THUNAR_DIR_RULES_FILE"
