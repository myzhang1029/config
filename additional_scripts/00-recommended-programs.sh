#!/bin/sh

# Attempt to install packages $1.
attempt_install()
{
    SUDO="$(command -v sudo > /dev/null 2>&1 && echo sudo || echo command)"
    for prog in apt-get dnf yum
    do
        if command -v "$prog" >/dev/null 2>&1
        then
            "$SUDO" "$prog" -y install "$1" && return 0
        fi
    done
    if command -v pacman >/dev/null 2>&1
    then
        yes | "$SUDO" pacman -S --needed "$1" && return 0
    fi
    return 1
}

attempt_install neovim
attempt_install python3
attempt_install python3-pip
attempt_install ctags
attempt_install exuberant-ctags
attempt_install aria2
attempt_install bash-completion
