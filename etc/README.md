# etc dotfiles
- shell以外のrcfilesを読み込ませるツールdotfilesの管理
- vim, tmuxとか
## dotfiles/
- rcfilesが入っている
## install.sh
- `./dotfiles/*`へのエイリアスをホームディレクトリに作成
- `./tmp`にホームディレクトリの既存ファイルを退避
## uninstal.sh
- install.shの逆
- ホームディレクトリのエイリアスを削除
- `./tmp`の退避ファイルをホームディレクトリに戻す
