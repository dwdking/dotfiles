alias cp='cp -i -v'
alias mv='mv -i -v'
alias mkdir='mkdir -p -v'
alias less='less -FSRXc'
cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
alias home='cd ~'
alias zshconfig="emacs ~/.zshrc"
alias ohmyzsh="emacs ~/.oh-my-zsh"
