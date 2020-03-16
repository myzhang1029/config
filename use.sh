#!/bin/bash
OLDWORKDIR="$(pwd)"
BASE="$(dirname "$0")"
FULLPATH="$(realpath "$BASE")"
IGNORE="use.sh README.md .gitignore backup"
cd "$BASE" || exit 1

backup_one() {
    echo "Moving ~/.$1 to backup/$1"
    mkdir -p "$OLDWORKDIR/backup"
    mv "$HOME/.$1" "$OLDWORKDIR/backup/$1"
}

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

for i in *
do
    if included "$i"
    then
        do_link $i
    fi
done
