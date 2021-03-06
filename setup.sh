#!/bin/bash

declare -a filenames=("$@")

if [ ${#filenames[@]} -eq 0 ]; then
    echo "usage: setup.sh [filenames]"
    exit 1
fi

for file in "${filenames[@]}"; do
    if [[ ! $file =~ "setup.sh" ]]; then
        echo "setting up $file"
        if [ -e ~/.$file ]; then
            if [ -L ~/.$file ]; then
                rm ~/.$file
            else
                mv --backup=numbered ~/.$file ~/.$file.bak
            fi
        fi
        ln -s $(dirname $(readlink -f $0))/$file ~/.$file;
    fi
done

exit 0
