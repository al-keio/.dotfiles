# .dotfiles
dotfilesを管理

# Installation

1. このレポジトリを"$HOME/.dotfiles"にクローンする
  ```
  $ git clone git@github.com:al-keio/.dotfiles.git ~/.dotfiles
  ```
2. インストール
  ```
  $ cd ~/.dotfiles
  $ make
  ```
3. ~/.gitconfigのnameとemailを更新

# build_tools/
ローカルでビルドする用のスクリプトを作った(root 権限が使えない時のため)

別にパッケージマネージャでもいい
- peco
- ctags, gtags
  - vim のコードジャンプで必要
- tmux
- libevent
  - tmux で必要
- ncurses
  - tmux で必要
  - ctag or gtag で必要

# scripts/
- スクリプトを管理

### tmuxをビルドしたいなら
```
$ make tmux.sh
```

# Uninstall
- 詳しくはMakefileを見て察して
```
$ make clean
      or
$ make clean-*
```
