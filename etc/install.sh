#!/bin/bash

cd $(dirname $0)

for f in *
do
  [[ "$f" == ".DS_Store" ]] && continue
  [[ "$f" == "install.sh" ]] && continue

  ln -Fisn "$PWD/$f" "$HOME/.$f"
done

if [ ! -f ~/.gitconfig ]; then
  cp -i "$HOME/.dotfiles/git/gitconfig.tmp" $HOME/.gitconfig
fi

mkdir -p "${HOME}/local/bin"

