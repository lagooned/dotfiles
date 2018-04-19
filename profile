# ~/.profile: executed by the command interpreter for login shells.

# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# umask 022

# Set user-defined locale
export LANG="en_US.UTF-8"

# xmodmap
if [ -f $HOME/.xmodmap ]; then
    xmodmap $HOME/.xmodmap &>/dev/null
fi

# xcape
if command -v xcape>/dev/null && ! pgrep -x "xcape">/dev/null; then
    xcape -e 'Control_L=Escape;Hyper_L=Return'
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# load nvm
if [ -d $HOME/.nvm ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
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

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi