# bash dotfiles
## dotfiles/
- rcfilesが入っている
## git-prompt.sh
- git情報をプロンプトに表示するためのやつ
## install.sh
- `./dotfiles/*`へのエイリアスをホームディレクトリに作成
- .bashrcの設定はデフォルトも使うので上書きではなく追記にしている(やめた方がよさそう)
- `./tmp`にホームディレクトリの既存ファイルを退避
## uninstal.sh
- install.shの逆
- ホームディレクトリのエイリアスを削除
- `./tmp`の退避ファイルをホームディレクトリに戻す
