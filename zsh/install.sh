TMP="$HOME/.dotfiles/zsh/tmp" # 退避用ディレクトリ

# install zinit and plugins
source "$HOME/.dotfiles/zsh/zinit_plugins"

setopt EXTENDED_GLOB

mkdir -p $TMP

for rcfile in "$HOME"/.dotfiles/zsh/dotfiles/*; do
  [[ -e $HOME/.${rcfile:t} ]] && [[ ! -L $HOME/.${rcfile:t} ]] && mv "$HOME/.${rcfile:t}" $TMP # 元のファイルを退避
  [[ -L $HOME/.${rcfile:t} ]] && rm "$HOME/.${rcfile:t}"
  ln -is "$rcfile" "$HOME/.${rcfile:t}"
done


