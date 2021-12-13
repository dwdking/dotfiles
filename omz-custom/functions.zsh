cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'

function tre() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}
