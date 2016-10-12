#!/bin/sh
#
# Install Homebrew

if test ! $(which brew)
then
  printf "\n› Installing Homebrew\n"

  printf "\n› brew update\n"
  brew update
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 2>&1 </dev/null
fi

exit 0
