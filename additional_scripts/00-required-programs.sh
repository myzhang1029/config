#!/bin/sh

attempt_install()
{
    SUDO="$(command -v sudo > /dev/null 2>&1 && echo sudo || echo command)"
    for prog in apt-get dnf yum
    do
        if command -v "$prog" >/dev/null 2>&1
        then
            "$SUDO" "$prog" install "$@" && return 0
        fi
    done
    if command -v pacman >/dev/null 2>&1
    then
        "$SUDO" pacman -S --needed "$@" && return 0
    fi
    return 1
}

attempt_install vim python3 bash-completion
