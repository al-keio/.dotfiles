non_zero () {
  rm -rf $TMP
  echo "cannot install gtags" 1>&2
  exit 1
}

# 作業ディレクトリを決定し，そこに移動
TMP=""
while :
do
  RAND=`cat /dev/urandom | tr -dc "[:alnum:]" | fold -w 20 | head -n 1`
  TMP="$HOME/tmp.${RAND}.build"
  [ ! -e $TMP ] && break
done
mkdir $TMP || non_zero
cd $TMP

# インストール
wget http://tamacom.com/global/global-6.6.2.tar.gz || non_zero
tar zxvf global-6.6.2.tar.gz || non_zero
cd global-6.6.2/
./configure --prefix=$HOME/local || non_zero
make || non_zero
make install || non_zero

rm -rf $TMP

# pygmentsをデフォルトで使用できる設定ファイルの作成
cp $HOME/local/share/gtags/gtags.conf ~/.globalrc
sed -ie 's/^\t\:tc=native\:$/\t\:tc=native\:tc=pygments\:/' ~/.globalrc

# pygments_parser.pyを実行するpythonを環境依存にする
sed -ie '1c \#\!\/usr\/bin\/env python' $HOME/local/share/gtags/script/pygments_parser.py

type pygmentise > /dev/null 2>&1 || \
  (echo "Please install Pygments" 2>&1; \
  echo "$ pip install pygments")

cp $HOME/local/share/gtags/gtags.vim $HOME/.vim/plugin

