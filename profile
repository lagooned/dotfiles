# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# Set user-defined locale
export LANG=$(locale -uU)

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# exec xmodmap
if [ -f ~/.xmodmap ]; then
    xmodmap ~/.xmodmap &>/dev/null
fi

# start xcape
if command -v xcape>/dev/null && ! pgrep -x "xcape">/dev/null; then
    xcape -e 'Control_L=Escape;Hyper_L=Return'
fi

# Make sure we start in home unless invoked by CHERE
if [ ! -z "${CHERE_INVOKING}" ]; then
  unset CHERE_INVOKING
fi
