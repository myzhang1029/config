#!/bin/bash
OLDWORKDIR="$(pwd)"
BASE="$(dirname $0)"
FULLPATH="$(realpath $BASE)"
IGNORE="use.sh README.md"
cd "$BASE"

backup_one() {
    echo "Moving ~/.$1 to backup/$1"
    mkdir -p "$OLDWORKDIR/backup"
    mv "$HOME/.$1" "$OLDWORKDIR/backup/$1"
}

do_link() {
    if [ -e "$HOME/.$1" ]
    then
        echo "~/.$1 exists, overwrite? [y/n]"
        read -r tf
        if [ "$tf" = "y" ]
        then
            backup_one $1
        else
            echo "Not overriding"
            continue
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
    if included $i
    then
        do_link $i
    fi
done
