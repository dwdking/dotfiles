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
alias gll='git log --graph --pretty=oneline --abbrev-commit'

if [[ -f "$HOME/src/github.com/Shopify/shopify-cli/bin/shopify" ]]; then
  alias shopdev='~/src/github.com/Shopify/shopify-cli/bin/shopify'
fi

if [[ "$SPIN" -eq "1" && "$USER" == "spin" ]]; then
  alias jc-dotfiles-log='journalctl -fxu dotfiles.service'
  alias sc-dotfiles-restart='systemctl restart dotfiles.service'
  alias sc-lf='systemctl list-units --failed'
  alias sc-ld='systemctl list-dependencies'
  alias spinfqdn='cat /etc/spin/machine/fqdn'
  alias shopadmin='open https://admin.web.`spinfqdn`/store/shop1'
  alias shoppartners='open https://partners.`spinfqdn`/internal'
  alias shop='open https://shop1.shopify.`spinfqdn`'
fi

alias myhtop='htop --user=dan'
alias gdiff='git diff --no-index'
