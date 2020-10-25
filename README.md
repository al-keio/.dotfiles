# .dotfiles
dotfilesを管理

# 使い方
## インストール

1. このレポジトリを"$HOME/.dotfiles"にクローンする  
```
# ハードコーディングしているので`~/.dotfiles`にクローンすること
$ git clone git@github.com:al-keio/.dotfiles.git ~/.dotfiles
```
2. インストール
```
# リポジトリルートへ移動
$ cd ~/.dotfiles

# ホームディレクトリにある既存dotfileを退避
# ホームディレクトリにこのリポジトリが用意したdotfileのシンボリックリンクを作成
$ make

# 特定のファイル群だけ設定も可
$ make etc
$ make bash
$ make zsh
```
3. ~/.gitconfigのnameとemailを更新

## アンインストール
```
# install時に作成したシンボリックリンクを削除
# install時に退避したdotfileをホームディレクトリに復元
$ make clean

# 特定のファイル群だけ設定も可
$ make clean-etc
$ make clean-bash
$ make clean-zsh
```

# ディレクトリ詳細
## *sh
シェルの設定ファイル等

## etc
シェル以外の設定ファイル等
- tmux
- vim
今後増えたらvimは分割してもいいかも？

## init_files
*sh共通の設定

## colors
itermのカラースキーム  
他人のを少し改造したのは入れている

## git
補完とgit設定ファイル

## build_tools
ローカルでビルドする用のスクリプトを作った(root 権限が使えない時のため)

## src
install・uninstallするためのスクリプトorライブラリ

## scripts
スクリプトを管理

