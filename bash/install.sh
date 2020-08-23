TMP="$HOME/.dotfiles/bash/tmp" # 退避用ディレクトリ
mkdir -p $TMP

for rcfile in "$HOME"/.dotfiles/bash/dotfiles/*; do
  [[ -e $HOME/.$(basename $rcfile) ]] && [[ ! -L $HOME/.$(basename $rcfile) ]] && mv "$HOME/.$(basename ${rcfile})" $TMP # 元のファイルを退避
  [[ "$(basename $rcfile)" == "bashrc" ]] && continue
  [[ -L $HOME/.$(basename $rcfile) ]] && rm $HOME/.$(basename $rcfile)
  ln -is "$rcfile" "$HOME/.$(basename ${rcfile})"
done

cp $TMP/.bashrc $HOME
rcfile="$HOME/.dotfiles/bash/dotfiles/bashrc"
(cat $HOME/.$(basename $rcfile) | grep -q "# my configs(.dotfiles)") || cat $rcfile >> $HOME/.$(basename ${rcfile})

