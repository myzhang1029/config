#!/bin/sh
# Invoke .aliases in .bashrc

# Avoid duplicate add
grep '\. ~/\.aliases' ~/.bashrc >/dev/null || cat <<'_EOS' >>~/.bashrc
# Added by myzhang1029/config.git
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi
_EOS
