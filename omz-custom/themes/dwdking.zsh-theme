if [[ "$SPIN" -eq "1" && "$USER" == "spin" ]]; then
  # Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
  autoload -Uz add-zsh-hook vcs_info
  # Enable substitution in the prompt.
  setopt prompt_subst
  # Run vcs_info just before a prompt is displayed (precmd)
  add-zsh-hook precmd vcs_info
  # add ${vcs_info_msg_0} to the prompt
  # e.g. here we add the Git information in red  
  PROMPT='꩜ $fg_bold[blue][$fg[red] %* $fg_bold[blue]] $fg_bold[blue][ $fg[green]%n@%m:$fg[red]%~ $fg[green]${vcs_info_msg_0_}$fg[blue] ]$reset_color
$ '
  RPROMPT=$'%{\x1b[0;3;37m%}'$(cat /etc/spin/machine/fqdn | sed "s/\\..*//")$'%{\x1b[0m%}'

  # Enable checking for (un)staged changes, enabling use of %u and %c
  zstyle ':vcs_info:*' check-for-changes true
  # Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
  zstyle ':vcs_info:*' unstagedstr ' *'
  zstyle ':vcs_info:*' stagedstr ' +'
  # Set the format of the Git information for vcs_info
  zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
  zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'
else
  # Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
  autoload -Uz add-zsh-hook vcs_info
  # Enable substitution in the prompt.
  setopt prompt_subst
  # Run vcs_info just before a prompt is displayed (precmd)
  add-zsh-hook precmd vcs_info
  # add ${vcs_info_msg_0} to the prompt
  # e.g. here we add the Git information in red  
  PROMPT='$fg_bold[blue][$fg[red] %* $fg_bold[blue]] $fg_bold[blue][ $fg[green]%n@%m:$fg[red]%~ $fg[green]${vcs_info_msg_0_}$fg[blue] ]$reset_color
$ '
  RPROMPT=$'%{\x1b[0;3;37m%}'$(cat /etc/spin/machine/fqdn | sed "s/\\..*//")$'%{\x1b[0m%}'

  # Enable checking for (un)staged changes, enabling use of %u and %c
  zstyle ':vcs_info:*' check-for-changes true
  # Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
  zstyle ':vcs_info:*' unstagedstr ' *'
  zstyle ':vcs_info:*' stagedstr ' +'
  # Set the format of the Git information for vcs_info
  zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
  zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'
fi
