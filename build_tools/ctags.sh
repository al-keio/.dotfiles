non_zero () {
  rm -rf $TMP
  echo "cannot install ctags" 1>&2
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

# インストール
git clone https://github.com/universal-ctags/ctags.git || non_zero
cd ctags
./autogen.sh || non_zero
./configure --prefix=$HOME/local || non_zero
make || non_zero
make install || non_zero

rm -rf $TMP

