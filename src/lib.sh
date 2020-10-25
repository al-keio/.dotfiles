# デバッグのタイトルのフォーマット
function print_title_debug () {
  printf "\033[38;5;33m▓▒░\033[m  \033[38;5;220m$1\033[m\n"
}

# バックアップをする
function backup_dotfiles () {
  # 引数を取得
  local target=$1
  local repo_root=$2

  local df_dir="${repo_root}/${TARGET}/dotfiles"     # dotfilesがあるディレクトリ
  local bu_dir="${repo_root}/cache/${target}/backup"       # 既存のファイルはここに退避

  print_title_debug "${target}: back up existing dotfiles to '${bu_dir}'"
  mkdir -p ${bu_dir}
  for dotfile_r in "${df_dir}"/*; do
    dotfile=`basename ${dotfile_r}`   # ファイル名部分だけ欲しい

    [[ ! -e $HOME/.${dotfile} ]] && continue    # バックアップするファイルがない
    [[ -L $HOME/.${dotfile} ]] && continue    # シンボリックリンクの場合はバックアップしない
    set -x
    mv -i "$HOME/.${dotfile}" $bu_dir         # 元のファイルを退避
    { set +x; } 2>/dev/null
  done

  echo ""
}

# バックアップしたファイルを復元する
function restore_dotfiles () {
  # 引数を取得
  local target=$1
  local repo_root=$2

  local df_dir="${repo_root}/${TARGET}/dotfiles"     # dotfilesがあるディレクトリ
  local bu_dir="${repo_root}/cache/${target}/backup"       # 既存のファイルはここに退避

  print_title_debug "${target}: restore dotfiles"
  for dotfile_r in "${df_dir}"/*; do
    dotfile=`basename ${dotfile_r}`   # ファイル名部分だけ欲しい

    if [ -L $HOME/.${dotfile} ]; then
      set -x
      rm "$HOME/.${dotfile}"
      { set +x; } 2>/dev/null
    elif [ -e $HOME/.${dotfile} ]; then
      set -x
      rm -i "$HOME/.${dotfile}"
      { set +x; } 2>/dev/null
    fi

    [[ ! -e "${bu_dir}/.${dotfile}" ]] && continue  # 復元するファイルがない

    set -x
    mv ${bu_dir}/.${dotfile} $HOME
    { set +x; } 2>/dev/null
  done

  echo ""
}

# ホームディレクトリにdotfileへのsymlinkを作成
function create_symlink_of_dotfiles () {
  # 引数を取得
  local target=$1
  local repo_root=$2

  local df_dir="${repo_root}/${TARGET}/dotfiles"     # dotfilesがあるディレクトリ
  local bu_dir="${repo_root}/cache/${target}/backup"       # 既存のファイルはここに退避

  print_title_debug "${target}: create symlink of dotfiles of '${df_dir}'"
  for dotfile_r in "${df_dir}"/*; do
    dotfile=`basename ${dotfile_r}`   # ファイル名部分だけ欲しい

    if [ -L $HOME/.${dotfile} ]; then
      set -x
      rm "$HOME/.${dotfile}"  # 既にsymlinkがある場合は削除
      { set +x; } 2>/dev/null
    fi
    set -x
    ln -is "$dotfile_r" "$HOME/.${dotfile}"      # symlink作成
    { set +x; } 2>/dev/null
  done
  echo ""
}

