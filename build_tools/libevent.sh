non_zero () {
  rm -rf $TMP
  echo "cannot install libevent" 1>&2
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

# libevent のビルド
cd $TMP
wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz || non_zero
tar zxf libevent-2.1.8-stable.tar.gz || non_zero
cd libevent-2.1.8-stable
./configure --prefix=${HOME}/local || non_zero
make || non_zero
make install || non_zero

rm -rf $TMP

