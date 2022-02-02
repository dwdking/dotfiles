#!/usr/bin/env zsh

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
    	--exclude "omz-custom" \
		--exclude "ohmyzsh" \
		-avh --no-perms . ~/;
	source ~/.zshrc;
}

doIt;
unset doIt;
