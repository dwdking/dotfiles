if [[ "$SPIN" -eq "1" && "$USER" == "spin" ]]; then
  export TZ=Canada/Eastern
  source /etc/zsh/zshrc.default.inc.zsh
fi

export WORK_HOST_NAME="Dans-MBP.lionsden"
export HOME_HOST_NAME="Dans-MBP-3.lionsden"

export ZSH="$HOME/dotfiles/ohmyzsh"
ZSH_THEME="dwdking"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
HIST_STAMPS="yyyy-mm-dd"
ZSH_CUSTOM="$HOME/dotfiles/omz-custom"

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

if [[ "$SPIN" -eq "1" && "$USER" == "spin" ]]; then
  plugins=(git colored-man-pages colorize gcloud ruby rust golang aliases urltools ubuntu)
elif [[ "$HOST" == "$WORK_HOST_NAME" ]]; then
  plugins=(git colored-man-pages colorize gcloud ruby rust golang aliases urltools macos brew ssh-agent sublime)
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
else
  plugins=(git colored-man-pages colorize gcloud ruby rust golang aliases urltools macos docker brew ssh-agent sublime)
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

source "$ZSH/oh-my-zsh.sh"

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }

if [[ "$HOST" == "$WORK_HOST_NAME" ]]; then
  # cloudplatform: add Shopify clusters to your local kubernetes config
  export KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}/Users/dan/.kube/config:/Users/dan/.kube/config.shopify.cloudplatform
  for file in /Users/dan/src/github.com/Shopify/cloudplatform/workflow-utils/*.bash; do source ${file}; done
  kubectl-short-aliases
fi

EDITOR=vi

export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"

# cloudplatform: add Shopify clusters to your local kubernetes config
export KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}/Users/dan/.kube/config:/Users/dan/.kube/config.shopify.cloudplatform
