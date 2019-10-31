
# ~/.bash_profile  -*- mode: Sh; -*-

# run profile
if [ -f "$HOME/.profile" ] ; then
    . "$HOME/.profile"
fi

# if running bash
if [ -n "$BASH_VERSION" ] ; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ] ; then
        . "$HOME/.bashrc"
    fi
fi
