TMP="$HOME/.dotfiles/bash/tmp"

# install時の追加ファイルの削除
for rcfile in "$HOME"/.dotfiles/bash/dotfiles/*; do
  rm -f "$HOME/.${rcfile:t}"
done

# 元のファイルに復元
for rcfile in "$TMP"/*; do
  cp rcfile $HOME
done
