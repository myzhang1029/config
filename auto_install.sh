#!/bin/sh -e
# wget -O- https://git.io/JU2Vz | sh
# download and pipe this script to sh to use the config!

# Attempt to install package $1.
attempt_install()
{
    SUDO="$(command -v sudo&&echo sudo)"
    for prog in apt-get dnf yum
    do
        if command -v "$prog" >/dev/null 2>&1
        then
            "$SUDO" "$prog" -y install "$1" && return 0
        fi
    done
    if command -v pacman >/dev/null 2>&1
    then
        yes | "$SUDO" pacman -S "$1" && return 0
    fi
    return 1
}
        
# Check if command $1 exists, try to install if not.
check_cmd()
{
    command -v "$1" >/dev/null 2>&1 && return 0
    echo "Required program $1 not found, attempting to install..." >&2
    attempt_install "$1" && return 0
    echo "Failed to install $1, please install manually and try again." >&2
    exit 1
}

check_cmd git

# Use HTTPS URLs to ensure this works on all machines
git clone https://github.com/myzhang1029/config.git config
cd config
./use.sh

# Change remote URL if asked to
if [ "$#" -gt 0 ]
then
    git remote set-url origin "$1"
fi
