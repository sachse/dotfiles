path_add() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="${PATH:+"$PATH:"}$1"
  fi
}

export DOTFILES=~/.dotfiles
export LANG=da_DK.UTF-8
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

path_add "/usr/local/sbin"
