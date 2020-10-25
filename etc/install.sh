#!/bin/bash
set -e

TARGET=$1
REPO_ROOT=$2

source "${REPO_ROOT}/src/lib.sh"

print_title_debug "create gitconfig"
if [ ! -f ~/.gitconfig ]; then
  set -x
  cp -i "$HOME/.dotfiles/git/gitconfig.tmp" $HOME/.gitconfig
fi

