TMP="$HOME/.dotfiles/bash/tmp"

# install時の追加ファイルの削除
for rcfile in "$HOME"/.dotfiles/bash/dotfiles/*; do
  rcfile=$(basename ${rcfile})
  rm -f "$HOME/.${rcfile:t}"
done

# 元のファイルに復元
for rcfile in "$HOME"/.dotfiles/bash/tmp/.*; do
  [[ "$(basename $rcfile)" == "." ]] && continue
  [[ "$(basename $rcfile)" == ".." ]] && continue
  cp ${rcfile} $HOME
done

rm -rf $TMP
