#!/usr/bin/env zsh

[[ -x `command -v wget` ]] && CMD="wget --no-check-certificate -O -"
[[ -x `command -v curl` ]] >/dev/null 2>&1 && CMD="curl -#L"

if [ -z "$CMD" ]; then
    echo "No curl or wget available. Aborting."
else
    echo "Installing dotfiles"
    mkdir -p "$HOME/dotfiles" && \
    eval "$CMD https://github.com/dwdking/dotfiles/tarball/master | tar -xzv -C ~/dotfiles --strip-components=1 --exclude='{.gitignore}'"
    . "$HOME/dotfiles/install"
fi
