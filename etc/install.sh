#!/bin/bash

cd $(dirname $0)

for f in .??*
do
  [[ "$f" == ".DS_Store" ]] && continue

  ln -Fis "$PWD/$f" "$HOME"
done

if [ ! -f ~/.gitconfig ]; then
  cp -i "$HOME/.dotfiles/git/gitconfig.tmp" $HOME/.gitconfig
fi

mkdir -p "${HOME}/local/bin"

