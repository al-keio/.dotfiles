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

# インストール
cd ctags
./autogen.sh
./configure --prefix=$HOME/local
make
make install

rm -rf $TMP
