alias cp='cp -i -v'
alias mv='mv -i -v'
alias mkdir='mkdir -p -v'
alias less='less -FSRXc'
alias home='cd ~'
alias zshconfig="vi ~/.zshrc"
alias ohmyzsh="vi ~/.oh-my-zsh"

if [[ "$SPIN" -eq "1" && "$USER" -eq "spin" ]]; then
  alias jc-dotfiles-log='journalctl -fxu dotfiles.service'
  alias sc-dotfiles-restart='systemctl restart dotfiles.service'
  alias sc-lf='systemctl list-units --failed'
  alias sc-ld='systemctl list-dependencies'
fi

alias myhtop='htop --user=dan'
alias gdiff='git diff --no-index'
