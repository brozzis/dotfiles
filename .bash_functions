#!/usr/bin/env bash

# upload ssh public key to a server
function authme {
  ssh $1 'cat >>.ssh/authorized_keys' <~/.ssh/id_rsa.pub
}

ghclone() {
  local usage="Usage: ghclone [-p] user repo"
  if (( $# == 3 )); then
    if [[ $1 == -p ]]; then
      local prefix="git@github.com:" user=$2 repo=$3
    else
      echo "$usage"
      return 1
    fi
  elif (( $# == 2 )); then
    local prefix="git://github.com/" user=$1 repo=$2
  else
    echo "$usage"
    return 1
  fi
  git clone "$prefix$user/$repo"
}

up() {
  local x= traverse= curpath=

  [[ $1 ]] || { cd ..; return; } # default to 1 level

  for x; do
    if [[ $x == +([[:digit:]]) ]]; then
      (( x == 0 )) && return # noop

      # build a path to avoid munging OLDPWD
      while (( x-- )); do
        traverse+=../
      done

      cd "$traverse"
    else
      curpath=$PWD

      while [[ $curpath && ! -e $curpath/$x ]]; do
        curpath=${curpath%/*}
      done

      if [[ $curpath ]]; then
        cd "$curpath"
      else
        printf "error: failed to locate \`%s' in a parent directory\n" "$x"
        return 1
      fi
    fi
  done
}

down() {
  local i=0 match type
  local -a matches

  if (( ! $# )); then
    printf 'usage: down [-f|-d] <file|dir> [matchnum]\n'
    printf '  -f    search for files (default)\n'
    printf '  -d    search for directories\n'
    return 1
  fi

  if [[ $1 == -@(d|f) ]]; then
    type=${1#-}
    shift
  else
    type=f
  fi

  while read -r -d '' match; do
    matches[++i]=$match
  done< <(find . -type $type -name "$1" -print0)

  if (( ! ${#matches[*]} )); then
    return 1
  fi

  if (( i == 1 )); then
    if [[ $type = d ]]; then
      cd "${matches[i]}"
    else
      cd "${matches[i]%/*}"
    fi
  else
    if (( $# == 1 )); then
      i=0
      for match in "${matches[@]}"; do
        (( ++i ))
        printf '%d) %s\n' "$i" "${matches[i]}"
      done
    else
      if (( $2 > i )); then
        return 1
      fi
      if [[ $type = d ]]; then
        cd "${matches[$2]}"
      else
        cd "${matches[$2]%/*}"
      fi
    fi
  fi
}
