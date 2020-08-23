#!/bin/bash

TMP="$HOME/.dotfiles/etc/tmp" # 退避用ディレクトリ

cd $(dirname $0)

for f in *
do
  [[ "$f" == ".DS_Store" ]] && continue
  [[ "$f" == "install.sh" ]] && continue

  rm -f "$HOME/.$f"
done

# 元のファイルに復元
for rcfile in "$TMP"/*; do
  cp -r rcfile $HOME
done
