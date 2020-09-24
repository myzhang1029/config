#!/bin/sh
# Invoke .aliases in .bashrc .zshrc or others

adder()
{
    # Avoid duplicate add
    grep 'ADDED BY MYZHANG1029/CONFIG' "$1" >/dev/null || cat <<'_EOS' >>"$1"

# ADDED BY MYZHANG1029/CONFIG
if [ -f ~/.shellrc_ext ]; then
    . ~/.shellrc_ext
fi
# END BY MYZHANG1029/CONFIG
_EOS
}

for rc in "$HOME/.zshrc" "$HOME/.bashrc"
do
    echo "Operating on $rc"
    [ -e "$rc" ] && adder "$rc"
done
