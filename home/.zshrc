if [[ "$SPIN" -eq "1" && "$USER" -eq "spin" ]]; then
  source /etc/zsh/zshrc.default.inc.zsh
fi

export ZSH="$HOME/dotfiles/ohmyzsh"
ZSH_THEME="dwdking"
ZSH_CUSTOM="$HOME/dotfiles/omz-custom"

plugins=(git colored-man-pages colorize gcloud ruby rust golang docker aliases brew)

source "$ZSH/oh-my-zsh.sh"
