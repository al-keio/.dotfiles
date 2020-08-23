#!/bin/bash

TMP="$HOME/.dotfiles/etc/tmp" # 退避用ディレクトリ
mkdir -p $TMP

cd $(dirname $0)

for f in *
do
  [[ "$f" == ".DS_Store" ]] && continue
  [[ "$f" == "install.sh" ]] && continue

  cp -r "$HOME/.${rcfile:t}" $TMP # 元のファイルを退避
  ln -Fisn "$PWD/$f" "$HOME/.$f"
done

if [ ! -f ~/.gitconfig ]; then
  cp -i "$HOME/.dotfiles/git/gitconfig.tmp" $HOME/.gitconfig
fi

mkdir -p "${HOME}/local/bin"

