#!/bin/sh
OLDWORKDIR="$(pwd)"
BASE="$(dirname $0)"
FULLPATH="$(realpath $BASE)"

cd "$BASE"

for i in *
do
    if [ "$i" = "use.sh" ]
    then
        continue
    fi
    if [ -e "$HOME/.$i" ]
    then
        echo "~/.$i exists, overwrite? [y/n]"
        read -r tf
        if [ "$tf" = "y" ]
        then
            echo "Moving ~/.$i to backup/$i"
            mkdir -p "$OLDWORKDIR/backup"
            mv "$HOME/.$i" "$OLDWORKDIR/backup/$i"
        else
            echo "Not overriding"
            continue
        fi
    fi
    ln -s "$FULLPATH/$i" "$HOME/.$i"
done
