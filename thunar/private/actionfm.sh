#!/usr/bin/env bash

# dependencies:
# i3get, updatefm, parserules, dunstfm, ulf, suggestpath

# ENVIRONMENT variables:
: "${LAUNCHFM_DEFAULT_CONTAINER:=D}"
: "${LAUNCHFM_SECONDARY_CONTAINER:=B}"
: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${THUNAR_BOOKMARKS:="$XDG_CONFIG_HOME/Thunar/bookmarks"}"

main() {
  # store output of i3get in i3got array
  i3got=($(i3get --print dict))

  # example i3get output:
  # 6291460
  # thunar-ina
  # ThunarD
  # /home/bud - File Manager

  # currently active window info:
  __wid="${i3got[0]}"     # window ID
  __ins="${i3got[1]}"     # instance name
  __cls="${i3got[2]}"     # class name
  __ttl="${i3got[*]:3}"   # full title
  __pth="${__ttl% -*}"    # directory open (trimmed title)
  __rul="${__ins#*-}"     # current rule (trimmed instance)
  __cnt="${__cls#Thunar}" # container name (trimmed class)

  # other container:
  [[ $__cnt = "$LAUNCHFM_DEFAULT_CONTAINER" ]] \
    && __ont=$LAUNCHFM_SECONDARY_CONTAINER     \
    || __ont=$LAUNCHFM_DEFAULT_CONTAINER

  # rules:
  # -------------------------------------
  # t|n|s - sort by time or name or size
  # i|l   - icon or list
  # [1-7] - iconsize
  # a|d   - ascending (A before B) or decending 
  #         (New before old) sort

  case "$1" in
    toggle-layout  ) togglerule i l                  ;;
    toggle-order   ) togglerule a d                  ;;
    toggle-sort    ) togglerule n t s                ;;
    save-layout    ) parserules "$__pth" "$__rul"    ;;
    display-layout ) temptitle "$__rul"              ;;
    rename-file    ) renamefile "$2"                 ;;
    delete-files   ) deletefiles "${@:2}"            ;;
    file-menu      ) filemenu "${@:2}"               ;;
    file-*         ) fileprompt "${1#*-}" "${@:2}"   ;;
    open-terminal  ) spawnterminal                   ;;
    display-path   ) dunstfm -m "${__pth/$HOME/'~'}" ;;
    add-bookmark   ) bookmark "$__pth"               ;;
  esac

}

bookmark() {

  if [[ -f $THUNAR_BOOKMARKS ]]; then
    awk -i inplace -v dir="${1/$HOME/'~'}" '
      NR==1 {print dir}
      $0 != dir {print}
    ' "$THUNAR_BOOKMARKS"
  else
    echo "${1/$HOME/'~'}" > "$THUNAR_BOOKMARKS"
  fi

}

spawnterminal() {
  urxvtc -name urxvt${__ont} -cd "${__pth}" 
  # i3-msg -q "[id=$__wid]" focus
}

suggestpath() {

  # if another thunar window then the current one
  # is visible, print the directory open in that 
  # window, else print $HOME

  local cid    # con_id of other window
  local ttl    # ttl of other window

  cid="$(i3viswiz --class Thunar${__ont})"

  [[ -n $cid ]] && ttl="$(i3get --conid "$cid" --print t)"

  if [[ -n $ttl ]]; then
    echo "${ttl% -*}"
  else
    echo "$HOME"
  fi
}

fileprompt() {

  a cmd isdir trg trgdir f newtrg force confirm

  case "${a:=$1}" in
    soft ) cmd="ln -s" ;;
    copy ) cmd="cp"    ;;
    move ) cmd="mv"    ;;
    hard ) cmd="ln"    ;;
    ulf  ) cmd="ulf"   ;;
    *    ) return 1    ;;
  esac


  shift

  [[ $cmd = ulf ]] && {
    [[ -d $1 || $# -gt 1 || ! -f $1 ]] && return 1
    msg="$(printf '%s\n' "Upload file:" "$1")"

    dunstfm -d "$__wid" -r 2233 -t 0 -m "${msg//$HOME/'~'}"
    confirm="$(echo -e "yes\nno" | i3menu --layout titlebar \
                                          --include l
        )"

    dunstify -C 2233
    [[ $confirm = yes ]] || return 1
    ulf "$1" &
    return
  }

  trg="$(suggestpath)"

  # if args = 1 && trg != ~, append to trg
  if [[ $# = 1 && $trg != "$HOME" ]]; then
    trg+="/${1##*/}"
  elif [[ $trg = "$HOME" ]]; then
    trg+="/"
  fi

  trg="$(i3menu --prompt "'$a to: '"   \
                --layout titlebar      \
                --filter "${trg/$HOME/'~'}"
      )"

  [[ -z $trg ]] && return 1

  # prefix relative path with current path
  [[ $trg =~ ^[/] ]] || trg="$__pth/$trg"

  trg="${trg/'~'/$HOME}"
  trgdir="${trg%/*}"
  
  # if trg is neither a file or directory
  # and multiselection, assume trg is (a new) dir
  [[ ! -e $trg ]] && (($#>1)) && trgdir="$trg"

  mkdir -p "$trgdir"

  for f in "${@}" ; do
    [[ -e $f ]] || continue
    # if action is copy and isdir, add -r option
    [[ -d $f ]] && [[ $a = copy ]] && isdir=1

    newtrg="$trg"
    [[ -d $trg ]] && newtrg="$trg/${f##*/}"
    # if target already exist, prompt for confirmation
    [[ -f $newtrg ]] && {
      msg="$(printf '%s\n' "File already exist, overwrite?" "$newtrg")"

      dunstfm -d "$__wid" -r 2233 -u critical  -m "${msg//$HOME/'~'}"
      confirm="$(echo -e "yes\nno" | i3menu --layout titlebar \
                                      --theme red \
                                      --include l
          )"

      dunstify -C 2233
      [[ $confirm = yes ]] || continue
      force=1
    }

    ${cmd} ${force:+-f} ${isdir:+-r} "$f" "$newtrg"

    force=
    isdir=
  done
}

filemenu() {

  local a

  actions=(
    "soft"
    "copy"
    "move"
    "hard"
  )

  [[ -d $1 || $# -gt 1 ]] || actions+=("ulf")

  a="$(printf '%s\n' "${actions[@]}" | \
       i3menu --layout titlebar        \
              --include l
      )"

  [[ -z $a ]] && return 1

  fileprompt "$a" "${@}"
}

deletefiles() {

  local msg a isdir

  # prompt with warning if more then one file
  # or a directory is selected:
  [[ $# -gt 1 || -d $1 ]] && {
    msg="Are you sure you want to delete:"
    msg+="$(printf '\n%s' "$@")"

    dunstfm -d "$__wid" -r 2233 -u critical  -m "${msg//$HOME/'~'}"
    a="$(echo -e "yes\nno" | i3menu --layout titlebar \
                                    --theme red \
                                    --include l
        )"

    dunstify -C 2233
    [[ $a = yes ]] || return 1
  }

  for f in "${@}" ; do
    [[ -e $f ]] || continue
    [[ -d $f ]] && isdir=1 || isdir=
    rm ${isdir:+-r} -f "$f"
  done

}

renamefile() {
  local f="$1"       # full path to original file

  # stop if $f is not a file or directory
  [[ -e $f ]] || return 1

  local d="${f%/*}"  # parent directory of file
  local o="${f##*/}" # old name without directory
  local n            # new file/dir-name

  n="$(i3menu --layout titlebar \
              --prompt '"rename: "' \
              --filter "$o"
      )"

  # if no new name is given or the same as the old
  [[ -z $n || $n = "$o" ]] && return 1

  # create subdir if needed
  [[ $n =~ [/] ]] && mkdir -p "$d/${n%/*}"

  # move/rename file
  mv "$f" "$d/$n" || notify-send "renaming $f failed"
}

temptitle() {
  local tf="${1:-$__rul}"  # temporary titleformat
  local to="$2"            # timeout in seconds
  local newtitle           # titleformat after timeout

  # if $to is empty or not an integer default to 2
  [[ ! $to =~ ^[0-9]+$ ]] && to=2

  i3-msg -q "[id=$__wid]" title_format "$tf"

  # reset the titleformat to narmal directory name
  # after time out. Necessary to get the actual title
  # of the window in case directory has changed during
  # the timeout period.
  {
    sleep "$to"
    newtitle="$(i3get --id "$__wid" --print t)"
    [[ -n $newtitle ]] && {
      newtitle="${newtitle% -*}"
      newtitle="${newtitle/$HOME\//}"
      # newtitle="${newtitle/$HOME/'~'}"
      i3-msg -q "[id=$__wid]" title_format "$newtitle"
    }
  } &
  # wait in the background, this scrip has:
  # singleinstance force, so the latest wait will
  # be the only one.

}

togglerule() {

  local rest newrule
  
  # all args except first.
  # remove all spaces from rest list
  rest="${*:2}" rest="${rest// /}"

  # if current rule contains the first argument
  # passed, replace it with the second argument
  if [[ $__rul =~ $1 ]]; then
    newrule="${__rul/$1/$2}"

  # if current rule contains any of the other
  # arguments, replace it with the first argument
  elif [[ $__rul =~ ([${rest}]) ]]; then
    newrule="${__rul/${BASH_REMATCH[1]}/$1}"
  fi

  # if new rule is really new, update layout and titleformat
  [[ $newrule != "$__rul" ]] && {
    updatefm -i "$__ins" -d "$__wid" -r "$newrule"
    temptitle "$newrule"
  }
  
}

#     SingleInstance force     #
# ---------------- ----------- #
pids="$(pgrep -f "bash $0")"
pids="${pids/$$/}"

[[ -n $pids ]] && kill ${pids}
unset pids
# ---- ----------------------- #

main "${@}"
