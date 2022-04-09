alias cp='cp -i -v'
alias mv='mv -i -v'
alias mkdir='mkdir -p -v'
alias less='less -FSRXc'
alias home='cd ~'
alias zshconfig="subl ~/.zshrc"
alias ohmyzsh="subl ~/dotfiles/ohmyzsh"
alias gw='./gradlew'
alias editGradle='subl ~/.gradle/gradle.properties'
alias editNpm='subl ~/.npmrc'
alias editSsh='subl ~/.ssh/config'

if [[ -a '~/src/github.com/Shopify/shopify-cli/bin/shopify' ]]; then
  alias shopdev='~/src/github.com/Shopify/shopify-cli/bin/shopify'
fi

if [[ "$SPIN" -eq "1" && "$USER" == "spin" ]]; then
  alias jc-dotfiles-log='journalctl -fxu dotfiles.service'
  alias sc-dotfiles-restart='systemctl restart dotfiles.service'
  alias sc-lf='systemctl list-units --failed'
  alias sc-ld='systemctl list-dependencies'
  alias spinfqdn='cat /etc/spin/machine/fqdn'
fi

alias myhtop='htop --user=dan'
alias gdiff='git diff --no-index'
