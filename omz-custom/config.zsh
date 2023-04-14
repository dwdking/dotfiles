GPG_TTY=$(tty)
export GPG_TTY
KEYID=0x8CCF4D624B38951C

zstyle ':completion:*:(ssh|scp|ftp|sftp):*' hosts $hosts
zstyle ':completion:*:(ssh|scp|ftp|sftp):*' users $users

[[ -f /opt/homebrew/bin/wasm-opt ]] && export WASM_OPT=/opt/homebrew/bin/wasm-opt
