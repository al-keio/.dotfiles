non_zero () {
  rm -rf $TMP
  echo "cannot install ncurses" 1>&2
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
cd $TMP
wget ftp://ftp.gnu.org/gnu/ncurses/ncurses-6.1.tar.gz || non_zero
tar zxf ncurses-6.1.tar.gz || non_zero
cd ncurses-6.1
./configure --enable-pc-files --prefix=${HOME}/local --with-pkg-config-libdir=${HOME}/local/lib/pkgconfig --with-termlib || non_zero
make || non_zero
make install || non_zero

rm -rf $TMP

