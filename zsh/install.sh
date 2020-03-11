# install zinit and plugins
source "$HOME/.dotfiles/zsh/zinit_plugins"

setopt EXTENDED_GLOB
for rcfile in "$HOME"/.dotfiles/zsh/dotfiles/*; do
  ln -is "$rcfile" "$HOME/.${rcfile:t}"
done


