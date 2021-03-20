#!/bin/sh
# Install vim-plug

# Install for neovim
INSTALL_DEST="${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload

mkdir -p "${INSTALL_DEST}"
# First make sure at least the bundled version can be used as fallback
cp "$(dirname "$0")"/plug.vim "${INSTALL_DEST}/plug.vim"

# The try to get newer versions
if type curl > /dev/null 2>&1
then
    curl -fLo "${INSTALL_DEST}/plug.vim" \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
elif type wget > /dev/null 2>&1
then
    wget -O "${INSTALL_DEST}/plug.vim" \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install for vim
## Download vim-plug
mkdir -p ~/.vim/autoload
[ -e ~/.vim/autoload/plug.vim ] && rm ~/.vim/autoload/plug.vim
ln -s "${INSTALL_DEST}/plug.vim" ~/.vim/autoload/plug.vim

# Make sure plugins are loaded
type nvim > /dev/null 2>&1 && nvim -c ':PlugInstall | qall' > /dev/null < /dev/null
# neovim handles non-tty inputs well but vim does not
type vim > /dev/null 2>&1 && vim -c ':PlugInstall | qall' > /dev/tty < /dev/tty
