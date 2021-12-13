# defaults loaded from /etc/zsh/zshrc. You can clobber this file with your own
# from a dotfiles repo to override.

echo "Running .zshrc"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="dwdking"
ZSH_CUSTOM="$HOME/dotfiles/omz-custom"

echo "Set ZSH theme and custom folder env vars"

plugins=(git colored-man-pages colorize)

echo "Set plugins"

source $ZSH/oh-my-zsh.sh

echo "Ran omz script"
