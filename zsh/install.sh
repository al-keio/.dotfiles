# install prezto
if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.dotfiles/zsh/dotfiles/*; do
  ln -is "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

ln -is "${ZDOTDIR:-$HOME}/.dotfiles/zsh/prompt_pure_setup" "${ZDOTDIR:-$HOME}/.zprezto/modules/prompt/functions/"
