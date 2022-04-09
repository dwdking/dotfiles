cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'

function tre() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

function extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *.jar)       unzip $1       ;;
            *.war)       unzip $1       ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }

secret () {
        output="${1}".$(date +%s).enc
        gpg --encrypt --armor --output ${output} -r 0x9C4DABF86FE410D5 -r dan@dwdking.ca "${1}" && echo "${1} -> ${output}"
}

secret-shopify () {
        output="${1}".$(date +%s).enc
        gpg --encrypt --armor --output ${output} -r 0x9C4DABF86FE410D5 -r danwd.king@shopify.com "${1}" && echo "${1} -> ${output}"
}

reveal () {
        output=$(echo "${1}" | rev | cut -c16- | rev)
        gpg --decrypt --output ${output} "${1}" && echo "${1} -> ${output}"
}