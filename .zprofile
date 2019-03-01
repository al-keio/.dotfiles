if [ -f ~/.zshrc ]; then
  . ~/.zshrc
fi

# Source other files
. ~/.dotfiles/aliases
. ~/.dotfiles/gitprompt
. ~/.dotfiles/paths
. ~/.dotfiles/envs
