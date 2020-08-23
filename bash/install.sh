TMP="$HOME/.dotfiles/bash/tmp" # 退避用ディレクトリ
mkdir -p $TMP

rcfile="$HOME/.dotfiles/bash/dotfiles/bashrc"
(cat $HOME/.$(basename $rcfile) | grep -q "# my configs(.dotfiles)") || cat $rcfile >> $HOME/.$(basename ${rcfile})

for rcfile in "$HOME"/.dotfiles/zsh/dotfiles/*; do
  cp "$HOME/.${rcfile:t}" $TMP # 元のファイルを退避
  [[ "$rcfile" == "bashrc" ]] && continue
  ln -is "$rcfile" "$HOME/.${rcfile:t}"
done
