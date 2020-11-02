#!/bin/sh

# Attempt to install packages $1.
attempt_install()
{
    SUDO="$(command -v sudo > /dev/null 2>&1 && echo sudo || echo command)"
    for prog in apt-get dnf yum
    do
        if command -v "$prog" >/dev/null 2>&1
        then
            # $1 not quoted for performance
            # shellcheck disable=SC2086
            "$SUDO" "$prog" -y install $1 && return 0
        fi
    done
    if command -v pacman >/dev/null 2>&1
    then
        # $1 not quoted for performance
        # shellcheck disable=SC2086
        yes | "$SUDO" pacman -S $1 && return 0
    fi
    return 1
}

attempt_install "neovim ctags aria2"
