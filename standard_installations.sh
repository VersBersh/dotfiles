# standard vm setup

# A better class of script...
set -o errexit          # Exit on most errors (see the manual)
set -o errtrace         # Make sure any error trap is inherited
set -o nounset          # Disallow expansion of unset variables
set -o pipefail         # Use last non-zero exit code in a pipeline
#set -o xtrace          # Trace the execution of the script (debug)

cd "$HOME/dotfiles"

# SHELLS
stow/bin/stow shell    # common to bash and zsh

stow/bin/stow bash     # preinstalled on Ubuntu

./install_package zsh --oh-my-zsh


# ONLY STOWED
stow/bin/stow editline  # preinstalled on Ubuntu

stow/bin/stow pgsql     # manual installation preferred

stow/bin/stow pip       # comes with python

stow/bin/stow xdg-user-dir  # GNOME stuff


# INSTALL AND STOW PACKAGES
./install_package curl

./install_package dig

./install_package dircolors

./install_package gcc

./install_package git

./install_package htop

./install_package less

./install_package pyenv --version 3.6.9 --virtualenv

./install_package stderred

./install_package tmux

./install_package vim

./install_package wget



