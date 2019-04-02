#!/usr/bin/env bash

: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${THUNAR_DIR_RULES_FILE:="$XDG_CONFIG_HOME/Thunar/dir-rules"}"

main() {
  targetdir="${1/$HOME/'~'}"
  targetrule="$2"

  [[ -f ${THUNAR_DIR_RULES_FILE} ]] || {
    echo "file doesn't exist"
    echo ". lna" > "${THUNAR_DIR_RULES_FILE}"
  }

  result="$(parsefunc)"

  if [[ -n $targetrule ]]; then
    # use readlink to get the source of the file
    # otherwise the link will die when we write to it.
    echo "$result" > "$(readlink -f "$THUNAR_DIR_RULES_FILE")"
  elif [[ -n $result ]]; then
    echo "$result"
  else
    exit 1
  fi
}


parsefunc() {
  awk \
    -v trgdir="${targetdir:-X}" \
    -v trgrul="${targetrule:-X}" \
  '
    /./ && /^[^#]/ && !firstline {firstline=NR}

    /./ && /^[^#]/ && trgdir ~ $1"$" {
      if (trgrul == "X") {
        print $2; exit
      } else if ($1 == ".") {
        alignat = index($0,$2)
      } else {
        sub($2,trgrul)
        trgdir="FOUND"
      }
    }

    trgrul != "X" {linez[NR]=$0}

    END {

      if (trgrul != "X") {
        
        if (trgdir != "FOUND" && alignat < length(trgdir))
          alignat = length(trgdir)+2

        if (alignat < 14) {alignat=14}

        # adjust header
        linez[firstline-2] = sprintf("%-" alignat-2 "s%s",
                                     "#  DIR-PATTERN",
                                     "| RULES")
        separatorline = sprintf("%-" alignat-2 "s","#")
        gsub(" ","-",separatorline)
        linez[firstline-1] = separatorline "|-------"


        for (l in linez) {
          if (l == firstline && trgdir != "FOUND") {
            printf("%-" alignat "s", trgdir)
            print trgrul
          }
          if (linez[l] ~ /./ && linez[l] ~ /^[^#]/) {
            split(linez[l],linus)
            printf("%-" alignat "s", linus[1])
            print linus[2]
          }
          else print linez[l]

        }
      }
      
    }

  ' "$THUNAR_DIR_RULES_FILE"
}

main "${@}"
