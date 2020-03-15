non_zero () {
  rm -rf $TMP
  rm -rf $HOME/local/src/include/lua
  echo "cannot install vim" 1>&2
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
mkdir $TMP
cd $TMP

# vim のビルド
git clone git@github.com:vim/vim.git || non_zero
cd vim/src
./configure --prefix=$HOME/local \
  --with-features=huge \
  --enable-multibyte \
  --enable-terminal \
  --disable-gui \
  --without-x \
  --enable-fail-if-missing \
  || non_zero
make || non_zero
make install || non_zero

rm -rf $TMP

