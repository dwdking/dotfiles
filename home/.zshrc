export ZSH="$HOME/dotfiles/ohmyzsh"
ZSH_THEME="dwdking"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
HIST_STAMPS="yyyy-mm-dd"
ZSH_CUSTOM="$HOME/dotfiles/omz-custom"

plugins=(git colored-man-pages colorize gcloud ruby rust golang aliases urltools macos docker brew ssh-agent sublime)
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

source "$ZSH/oh-my-zsh.sh"

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)
