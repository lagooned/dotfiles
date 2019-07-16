#!/bin/bash

declare -a filenames=(
    # "bash_aliases"
    # "bashrc"
    # "bashrc_custom"
    # "bashrc_tmux"
    # "inputrc"
    # "profile"
    # "profile_custom"
    # "profile_custom_osx"
    # "screenrc"
    "tmux.conf"
    # "xmodmap"
)

for file in "${filenames[@]}"
do
    echo "setting up $file"
    if [ -e ~/.$file ]; then
        if [ -L ~/.$file ]; then
            rm ~/.$file
        else
            mv ~/.$file ~/.bak
        fi
    fi
    ln -s $(dirname $(readlink -f $0))/$file ~/.$file;
done
