TMP="$HOME/.dotfiles/zsh/tmp"
rm -rf "$HOME/.zinit"

# install時の追加ファイルの削除
for rcfile in "$HOME"/.dotfiles/zsh/dotfiles/*; do
  rm -f "$HOME/.${rcfile:t}"
done

# 元のファイルに復元
for rcfile in "$TMP"/*; do
  cp rcfile $HOME
done
