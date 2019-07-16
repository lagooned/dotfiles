#!/bin/bash

declare -a filenames=("$@")

if [ ${#filenames[@]} -eq 0 ]; then
    echo "usage: setup.sh [filenames]"
else
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
fi
