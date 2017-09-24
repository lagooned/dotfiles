# some ls aliases
alias ll='ls -alF'
alias lh='ls -lh'
alias lls='ls -lhSr'
alias llh='ls -lh'
alias la='ls -A'
alias l='ls -CF'

# produce some dazzling colors on the terminal. you'll probably want to run `reset` afterward.
alias dazzle='while :;do printf "\e[%d;%dH\e[48;5;%dm \e[0m" $(($RANDOM%$LINES)) $(($RANDOM%$COLUMNS)) $(($RANDOM%216 )); done'

# brownnoise
alias brownnoise='play -v 0.2 -c 2 --null synth brownnoise reverb bass 6 treble -3 echos 0.8 0.9 1000 0.3 1800 0.25'

# function cd_func
#
# This function defines a 'cd' replacement function capable of keeping, 
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
#
# jengler (lagooned/dotfiles) added ability to use multiple dots to go up
# multiple directories
cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  # cd up for every . past .
  # author jengler (lagooned)
  if [[ "$1" =~ ^\.\.+$ ]]; then
    local a dir;
    a=${#1};
    while [ $a -ne 1 ]; do 
      dir=${dir}"../";
      ((a--));
    done;
    the_new_dir=$dir
  fi

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  #
  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=cnt-1
    fi
  done

  return 0
}

alias cd=cd_func

