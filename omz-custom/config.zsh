GPG_TTY=$(tty)
export GPG_TTY
KEYID=0x8CCF4D624B38951Ca

zstyle ':completion:*:(ssh|scp|ftp|sftp):*' hosts $hosts
zstyle ':completion:*:(ssh|scp|ftp|sftp):*' users $users
