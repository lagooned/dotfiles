# ~/.bash_aliases  -*- mode: Sh; -*-

# load ~/.bash_funcs if present
if [ -f "$HOME/.bash_funcs" ]; then
    . "$HOME/.bash_funcs"
    alias cd=cd_func
fi

# default to human readable figures
alias df='df -h'
alias du='du -h'

# added protection
alias rm='rm -I --preserve-root'

# nicer mkdir
alias mkdir='mkdir -pv'

# continue wget
alias wget='wget -c'

# misc
alias h='history'
alias j='jobs'
alias b='bg'
alias f='fg'

# git alias translations
if command -v git>/dev/null; then
    git_aliases=$(git config --get-regexp '^alias\.' \
        | cut -f 1 -d ' ' \
        | cut -f 2 -d '.');
    for a in $git_aliases; do
        alias g$a="git $a"
    done
fi

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

# load ~/.bashrc_tmux if present
if [ -f "$HOME/.bashrc_tmux" ]; then
    . "$HOME/.bashrc_tmux"
fi

# load ~/.bash_prompt if present and if not in emacs
if [ -f "$HOME/.bash_prompt" ] && [ -z ${INSIDE_EMACS} ]; then
    . "$HOME/.bash_prompt"
fi
