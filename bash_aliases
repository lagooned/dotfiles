# ~/.bash_aliases

# nice prompt with time
export PS1_TOP="[\[\e[32m\]\t\[\e[m\]] \[\e[31m\]\u\[\e[m\]@\[\e[35m\]\h\[\e[m\] \W"
export PS1_BOTTOM="\n \[\e[32m\]\\$\[\e[m\] "

# default to human readable figures
alias df='df -h'
alias du='du -h'

# less color support
alias less='less -r'

# added protection
alias rm='rm -I --preserve-root'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r "$HOME/.dircolors" && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some ls aliases
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -lF'
alias lla='ls -alF'
alias lls='ls -lhSr'
alias lh='ls -lh'
alias llh='ls -lh'

# redefine on osx
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

cd_func () {

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

invert_pdf() {
    if [ -n "$1" ] || [ -n "$2" ]; then
        ghostscript -o "$2" -sDEVICE=pdfwrite -c "{1 exch sub}{1 exch sub}{1 exch sub}{1 exch sub} setcolortransfer" -f "$1"
    else
        echo "Usage: invert_pdf input.pdf output.pdf"
    fi
}

highlight() {
    grep --color=always -E "$1|\$"
}

# load ~/.bashrc_tmux if present
if [ -f "$HOME/.bashrc_tmux" ]; then
    . "$HOME/.bashrc_tmux"
fi

# load ~/.bash_git_prompt if present
if [ -f "$HOME/.bash_git_prompt" ]; then
    . "$HOME/.bash_git_prompt"
fi

# create prompt
export PS1=$PS1_TOP$PS1_BOTTOM