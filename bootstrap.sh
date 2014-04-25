#!/usr/bin/env bash

DOTFILES_DIR="$(pwd)"

set -e

echo ''

info () {
  printf "  [ \033[00;34m..\033[0m ] %s", "$1"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] %s", "$1"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n", "$1"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n", "$1"
  echo ''
  exit
}

link_files () {
  ln -s "$1" "$2"
  success "linked $1 to $2"
}

install_dotfiles () {
  info 'installing dotfiles'

  overwrite_all=false
  backup_all=false
  skip_all=false

  for source in `find $DOTFILES_DIR -maxdepth 2 -name \*.symlink`
  do
    dest="$HOME/.`basename \"${source%.*}\"`"

    if [ -f "$dest" ] || [ -d "$dest" ]
    then

      overwrite=false
      backup=false
      skip=false

      if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
      then
        user "File already exists: `basename $source`, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac
      fi

      if [ "$overwrite" == "true" ] || [ "$overwrite_all" == "true" ]
      then
        rm -rf "$dest"
        success "removed $dest"
      fi

      if [ "$backup" == "true" ] || [ "$backup_all" == "true" ]
      then
        mv "$dest" "$dest"\.backup
        success "moved $dest to $dest.backup"
      fi

      if [ "$skip" == "false" ] && [ "$skip_all" == "false" ]
      then
        link_files "$source" "$dest"
      else
        success "skipped $source"
      fi

    else
      link_files "$source" "$dest"
    fi

  done
}

# Install Homebrew first, as it's needed for almost everything else
#homebrew/install.sh 2>&1

install_dotfiles

# Find the installers and run them iteratively
#find . -name install.sh | while read installer ; do sh -c "${installer}" ; done

echo ''
echo '  Done.'
