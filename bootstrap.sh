#!/usr/bin/env zsh

set -e

OH_MY_ZSH_DIR="ohmyzsh"

git submodule update --init --recursive "${OH_MY_ZSH_DIR}"

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
    	--exclude "omz-custom" \
		--exclude "ohmyzsh" \
		--exclude "git" \
		-avh --no-perms . ~/;
	source ~/.zshrc;
}

doIt;
unset doIt;
