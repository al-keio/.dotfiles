. ~/.dotfiles/gitprompt

export TERM=xterm-256color
# 色を使用出来るようにする
autoload -Uz colors

# emacs 風キーバインドにする
bindkey -e

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
HISTTIMEFORMAT=%Y/%m/%d%H:%M:%S

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
  /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


# gitの設定
setopt PROMPT_SUBST
setopt TRANSIENT_RPROMPT

# プロンプト
precmd () {
  if [ "$(uname)" = 'Darwin' ]; then
    PROMPT="[%B%F{green}%n%f%b@%B%F{red}Mac%f%b %F{cyan}%U%~%u%f"
  else
    PROMPT="[%B%F{green}%n%f%b@%B%F{red}%m%f%b %F{cyan}%U%~%u%f"
  fi

  if type "__git_ps1" > /dev/null 2>&1; then
    PROMPT="${PROMPT}%B%F{magenta}$(__git_ps1 " (%s)")%f%b"
  fi

  if [ -n "$VIRTUAL_ENV" ]; then
    local VPROMPT="${VIRTUAL_ENV##*/}"
    local VPROMPT="%B%F{yellow}(pipenv: ${VPROMPT%-*})%f%b"
    #RPROMPT="${VPROMPT}"
    PROMPT="${PROMPT} ${VPROMPT}"
  fi
  PROMPT="${PROMPT}]
"
  if [ "`id -u`" -eq 0 ]; then
    PROMPT="${PROMPT}# "
  else
    PROMPT="${PROMPT}$ "
  fi
}


########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

# no nomatch
setopt nonomatch
########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

if type "$IFT" > /dev/null 2>&1; then
  function ift-history-selection() {
    if [ "$(uname)" = 'Darwin' ]; then
      BUFFER="`history -n 1 | tail -r  | awk '!a[$0]++' | $IFT`"
    else
      BUFFER=`history -n 1 | tac | awk '!a[$0]++' | $IFT`
    fi
    CURSOR=$#BUFFER
  }

  zle -N ift-history-selection
  bindkey '^R' ift-history-selection
fi
