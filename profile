
# ~/.profile  -*- mode: Sh; -*-

# load custom profile
if [ -f "$HOME/.profile_custom" ]; then
    . "$HOME/.profile_custom"
fi

# load custom osx profile
if [ -f "$HOME/.profile_custom_osx" ] ; then
    . "$HOME/.profile_custom_osx"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private .local/bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
