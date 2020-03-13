for rcfile in "$HOME"/.dotfiles/bash/dotfiles/*; do
  (cat $HOME/.$(basename $rcfile) | grep -q "# my configs(.dotfiles)") || cat $rcfile >> $HOME/.$(basename ${rcfile})
done


