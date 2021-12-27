alias cp='cp -i -v'
alias mv='mv -i -v'
alias mkdir='mkdir -p -v'
alias less='less -FSRXc'
alias home='cd ~'
alias zshconfig="emacs ~/.zshrc"
alias ohmyzsh="emacs ~/.oh-my-zsh"

if [ "$SPIN" ]; then
  alias dotfileslog='journalctl --unit dotfiles.service'
  alias dotfilesrestart='systemctl restart dotfiles.service'
  alias list-failed='systemctl list-units --failed'
fi

alias myhtop='htop --user=dan'
