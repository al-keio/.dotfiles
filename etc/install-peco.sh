# pecoのインストール
if [ "$(uname)" = 'Darwin' ]; then
  brew install peco
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  ARCH=`uname -m`

  BASE_URL="https://github.com/peco/peco/releases/download"
  PECO_VER="v0.5.3"

  unset DL_URL

  if [[ $ARCH == "i386" ]]; then
    DL_DIR="peco_linux_386"
  elif [[ $ARCH == "x86_64" ]]; then
    DL_DIR="peco_linux_amd64"
  elif [[ $ARCH == *"armv5"* ]] || [[ $ARCH == *"armv6"* ]] || [[ $ARCH == *"armv7"* ]]; then
    DL_DIR="peco_linux_arm"
  elif [[ $ARCH == *"armv8"* ]]; then
    DL_DIR="peco_linux_arm64"
  else
    echo "Can not find the cpu architecture of peco" 1>&2
  fi

  if [ -n $DL_URL ]; then
    wget "${BASE_URL}/${PECO_VER}/${DL_DIR}.tar.gz"
    if [ $? -eq 0 ]; then
      mkdir "${HOME}/.peco"
      tar -zxvf "${DL_DIR}.tar.gz" -C "${HOME}/.peco" --strip-components 1
      cp "${HOME}/.peco/peco" "${HOME}/local/bin"
      rm -rf "${DL_DIR}.tar.gz" .peco
    else
      echo "Can not download peco source" 1>&2
      exit 1
    fi
  fi
fi

