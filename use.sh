#!/bin/bash

OLDWORKDIR="$(pwd)"
BASE="$(dirname "$0")"
FULLPATH="$(realpath "$BASE")"
IGNORE="use.sh README.md .gitignore backup"

cd "$BASE" || exit 1

# Back up a file with structure.
# @param 1 name or path of the file to back up.
backup_one() {
    echo "Moving ~/.$1 to backup/$1"
    mkdir -p "$OLDWORKDIR/backup/$(dirname $1)"
    mv "$HOME/.$1" "$OLDWORKDIR/backup/$1"
}

# Link a file to $HOME.
# @param 1 name or path of the file to link.
do_link() {
    # Possible broken link
    if [ -e "$HOME/.$1" ] || [ -L "$HOME/.$1" ]
    then
        echo "~/.$1 exists, overwrite? [y/n]"
        read -r tf
        if [ "$tf" = "y" ]
        then
            backup_one "$1"
        else
            echo "Not overwriting"
            return
        fi
    fi
    ln -s "$FULLPATH/$1" "$HOME/.$1"
}

# Check if a file should be linked.
# @param 1 name of the file.
included() {
    for en in $IGNORE
    do
        if [ "$1" = "$en" ]
        then
            return 1
        fi
    done
    return 0
}

# Link files in a folder recursively.
# @param 1 name or path of the folder.
link_folder() {
    mkdir -p "$HOME/.$1"
    for d in $1/*
    do
        if [ -d "$d" ]
        then
            link_folder "$d"
        else
            do_link "$d"
        fi
    done
}

for i in *
do
    if included "$i"
    then
        if [ -d "$i" ]
        then
            link_folder "$i"
        else
            do_link "$i"
        fi
    fi
done
