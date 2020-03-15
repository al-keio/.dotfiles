non_zero () {
  rm -rf $TMP
  echo "cannot install tmux" 1>&2
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

# tmux のビルド
cd $TMP
wget https://github.com/tmux/tmux/releases/download/2.8/tmux-2.8.tar.gz || non_zero
tar zxf tmux-2.8.tar.gz || non_zero
cd tmux-2.8
PKG_CONFIG_PATH=${HOME}/local/lib/pkgconfig ./configure --prefix=${HOME}/local --enable-static LDFLAGS="-L${HOME}/local/lib" CFLAGS="-I${HOME}/local/include" || non_zero
make || non_zero
make install || non_zero

rm -rf $TMP

