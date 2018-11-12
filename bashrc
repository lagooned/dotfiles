# ~/.bashrc

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# disable xon/xoff
[[ "$-" == *i* ]] && stty -ixon

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=100000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm*) TERM=xterm-256color;;
    xterm-color|*-256color) color_prompt=yes;;
esac

# alias definitions.
if [ -f "$HOME/.bash_aliases" ]; then
    . "$HOME/.bash_aliases"
fi

# bashrc_custom
if [ -f "$HOME/.bashrc_custom" ] ; then
    . "$HOME/.bashrc_custom"
fi

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Make sure we start in home unless invoked by CHERE
if [ ! -z "${CHERE_INVOKING}" ]; then
    unset CHERE_INVOKING
fi
