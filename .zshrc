# defaults loaded from /etc/zsh/zshrc. You can clobber this file with your own
# from a dotfiles repo to override.

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="dwdking"
ZSH_CUSTOM="$HOME/dotfiles/omz-custom"

plugins=(git colored-man-pages colorize)

source $ZSH/oh-my-zsh.sh
