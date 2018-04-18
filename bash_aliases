# some ls aliases
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -lF'
alias lla='ls -alF'
alias lls='ls -lhSr'
alias lh='ls -lh'
alias llh='ls -lh'

if [[ $(uname -s) == Darwin ]]; then
    alias ls='ls -G'
    alias l='ls -CFG'
    alias la='ls -AG'
    alias ll='ls -lFG'
    alias lla='ls -alFG'
    alias lls='ls -lhSrG'
    alias lh='ls -lhG'
    alias llh='ls -lhG'
fi

# produce some dazzling colors on the terminal. you'll probably want to run `reset` afterward.
alias dazzle='while :;do printf "\e[%d;%dH\e[48;5;%dm \e[0m" $(($RANDOM%$LINES)) $(($RANDOM%$COLUMNS)) $(($RANDOM%216 )); done;'

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

tmux() ( ORIG_PWD_FOR_TMUX="${PWD}" command tmux "$@"; )

# start tmux on shell start if it is available
if command -v tmux>/dev/null; then
    [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

export PS1=" [\[\e[32m\]\t\[\e[m\]] \[\e[31m\]\u\[\e[m\]@\[\e[35m\]\h\[\e[m\] \W\[\e[36m\]\`parse_git_branch\`\[\e[m\] \[\e[32m\]\\$\[\e[m\] "