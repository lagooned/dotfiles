# JARED ENGLER BASHRC

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# disable xon/xoff
[[ "$-" == *i* ]] && stty -ixon

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm*) TERM=xterm-256color;;
    xterm-color|*-256color) color_prompt=yes;;
esac

# default to human readable figures
alias df='df -h'
alias du='du -h'

# misc
alias whence='type -a'
alias less='less -r'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# xmodmap
if [ -f $HOME/.xmodmap ]; then
    xmodmap $HOME/.xmodmap &>/dev/null
fi

# xcape
if command -v xcape>/dev/null && ! pgrep -x "xcape">/dev/null; then
    xcape -e 'Control_L=Escape;Hyper_L=Return'
fi

# Make sure we start in home unless invoked by CHERE
if [ ! -z "${CHERE_INVOKING}" ]; then
    unset CHERE_INVOKING
fi

# load nvm
if [ -d $HOME/.nvm ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    alias node="env NODE_NO_READLINE=1 rlwrap node"
fi

# rbenv
if which rbenv > /dev/null; then
    eval "$(rbenv init -)";
fi

# php
if [ -d /usr/local/php5/bin ]; then
    export PATH=/usr/local/php5/bin:$PATH
fi

# perlbrew
if [ -d $HOME/perl5/perlbrew ]; then
    PATH="$HOME/perl5/bin${PATH+:}${PATH}"; export PATH;
    PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
    PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
    PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
    PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
   source $HOME/perl5/perlbrew/etc/bashrc
fi