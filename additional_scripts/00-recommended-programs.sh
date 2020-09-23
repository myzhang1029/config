#!/bin/sh

# Attempt to install packages $1.
attempt_install()
{
    for prog in apt-get dnf yum
    do
        if command -v "$prog" >/dev/null 2>&1
        then
            # $1 not quoted for performance
            # shellcheck disable=SC2086
            sudo "$prog" -y install $1 && return 0
        fi
    done
    if command -v pacman >/dev/null 2>&1
    then
        # $1 not quoted for performance
        # shellcheck disable=SC2086
        yes | sudo pacman -S $1 && return 0
    fi
    return 1
}

attempt_install "vim ctags aria2"
