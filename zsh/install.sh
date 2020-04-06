#!/bin/sh
#
# Set up zsh and oh-my-zsh

printf "\n› Setting up zsh\n"

if ! [[ $SHELL == "/usr/local/bin/zsh" ]]
then
  sudo sh -c "sudo printf \"/usr/local/bin/zsh\n\" >> /etc/shells"
  chsh -s /usr/local/bin/zsh
fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" > /tmp/oh-my-zsh-install.log

# Copy theme
cp "$DOTFILES_ROOT/zsh/denkristoffer.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/"

# Copy all zsh files to $HOME/.oh-my-zsh/custom
# config_files=($(dirname "$(pwd)")/**/*.zsh)
# echo $config_files

# for file in ${config_files}
# do
#   filename=$(basename "$file")
#   echo $filename
#   # cp $file $HOME/.oh-my-zsh/custom/
# done
