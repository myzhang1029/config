#!/bin/sh

OLDWORKDIR="$(pwd)"
BASE="$(dirname "$0")"
if type realpath >/dev/null 2>&1
then
    FULLPATH="$(realpath "$BASE")"
else
    # realpath not available
    case "$BASE" in
        # Full path supplied in $0
        /*) FULLPATH="$BASE";;
        # Relative path supplied in $0
        *) FULLPATH="$(pwd -P)/$BASE";;
    esac
fi
IGNORE="use.sh auto_install.sh make_gitignore.sh README.md .gitignore backup additional_scripts"
INSTALLED=""
yes=n
force=n

cd "$BASE" || exit 1

while [ -n "$1" ]; do
    case "$1" in
        # Link without backup
        -f)
            force=y
           ;;
        # Answer yes to all questions
        -y)
            yes=y
           ;;
        --)
            shift
            break
            ;;
        -*)
            echo "Unknown option: $1"
            exit 2
            ;;
        *)
            set_node_name "$1"
            ;;
    esac
    shift
done

# Back up a file with structure.
# @param 1 name or path of the file to back up.
backup_or_rm_one() {
    if [ "$force" = y ]
    then
        echo "Deleting ~/.$1"
        rm -f "$HOME/.$1"
    else
        echo "Moving ~/.$1 to backup/$1"
        mkdir -p "$OLDWORKDIR/backup/$(dirname "$1")"
        mv "$HOME/.$1" "$OLDWORKDIR/backup/$1"
    fi
}

# Link a file to $HOME.
# @param 1 name or path of the file to link.
do_link() {
    # If it is already linked to this file, we do nothing
    if [ "$(readlink "$HOME/.$1" 2> /dev/null)" = "$PWD/$1" ]
    then
        return 0
    fi
    # Possible broken link
    if [ -e "$HOME/.$1" ] || [ -L "$HOME/.$1" ]
    then
        # shellcheck disable=SC2088 # ~ intentionally not expanded
        echo "~/.$1 exists, overwrite? [y/n]"
        if [ "$yes" = y ]
        then
            tf=y
        else
            read -r tf
        fi
        if [ "$tf" = y ]
        then
            backup_or_rm_one "$1"
        else
            echo "Not overwriting"
            return
        fi
    fi
    ln -s "$FULLPATH/$1" "$HOME/.$1"
    INSTALLED="$INSTALLED$1\n"
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
    for d in "$1"/*
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

echo "Linked these files:"
# shellcheck disable=SC2059 # We want to intepret '\n'
printf "$INSTALLED\n"

for script in additional_scripts/*.sh
do
    echo "Run $script? [y/n]"
    read -r tf
    if [ "$tf" = "y" ]
    then
        echo "Running $script"
        $script
    fi
done
