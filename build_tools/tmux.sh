# 作業ディレクトリを決定し，そこに移動
TMP=""
while :
do
  RAND=`cat /dev/urandom | tr -dc "[:alnum:]" | fold -w 20 | head -n 1`
  TMP="$HOME/tmp.${RAND}.build"
  [ ! -e $TMP ] && break
done
mkdir $TMP || echo "cannot install ctags" 1>&2; exit
cd $TMP

# libevent のビルド
cd $TMP
wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
tar zxf libevent-2.1.8-stable.tar.gz
cd libevent-2.1.8-stable
./configure --prefix=${HOME}/local
make
make install

# ncurses のビルド
cd $TMP
wget ftp://ftp.gnu.org/gnu/ncurses/ncurses-6.1.tar.gz
tar zxf ncurses-6.1.tar.gz
cd ncurses-6.1
./configure --enable-pc-files --prefix=${HOME}/local --with-pkg-config-libdir=${HOME}/local/lib/pkgconfig --with-termlib
make
make install

# tmux のビルド
cd $TMP
wget https://github.com/tmux/tmux/releases/download/2.8/tmux-2.8.tar.gz
tar zxf tmux-2.8.tar.gz
cd tmux-2.8
PKG_CONFIG_PATH=${HOME}/local/lib/pkgconfig ./configure --prefix=${HOME}/local --enable-static LDFLAGS="-L${HOME}/local/lib" CFLAGS="-I${HOME}/local/include"
make
make install

rm -rf $TMP
