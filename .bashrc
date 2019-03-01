# Source other files
. ~/.dotfiles/aliases
. ~/.dotfiles/gitprompt
. ~/.dotfiles/paths

export TERM=xterm-256color

# gitの設定
if [ "$(uname)" = 'Darwin' ]; then
  source /usr/local/etc/bash_completion.d/git-completion.bash
fi

# プロンプト
function promps {
  #色の変数宣言(始点は使いたい色，終点は_WHITEで挟む)
  local  _CYAN="\[\e[0;36m\]"
  local  _LIGHTRED="\[\e[1;31m\]"
  local  _LIGHTGREEN="\[\e[1;32m\]"
  local  _LIGHTPURPLE="\[\e[1;35m\]"
  local  _WHITE="\[\e[00m\]"

  # プロンプトの定義
  if [ "$(uname)" = 'Darwin' ]; then
    PS1="[${_LIGHTGREEN}\u${_WHITE}@${_LIGHTRED}Mac${_WHITE} ${_CYAN}\W${_WHITE}${_LIGHTPURPLE}"'$(__git_ps1)'"${_WHITE}]\n$ "
  elif type "__git_ps1" > /dev/null 2>&1; then
    PS1="[${_LIGHTGREEN}\u${_WHITE}@${_LIGHTRED}\h${_WHITE} ${_CYAN}\W${_WHITE}${_LIGHTPURPLE}"'$(__git_ps1)'"${_WHITE}]\n$ "
  else
    PS1="[${_LIGHTGREEN}\u${_WHITE}@${_LIGHTRED}\h${_WHITE} ${_CYAN}\W${_WHITE}]\n$ "
  fi
  # PS1に関して
  # 変数使う時はダブルクオート(")で囲う必要があり
  # $(__git_ps1)はシングルクオートで囲う必要があるため
  # $(__git_ps1)を個別にシングルクオートで囲っている
  # $(__git_ps1)はgitで管理されたディレクトリに入ると出現する
}
promps
# プロンプト(終)

