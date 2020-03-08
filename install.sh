#!/bin/bash

cd $(dirname $0)

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue
  [[ "$f" == ".gitignore" ]] && continue

  ln -Fis "$PWD/$f" $HOME
done

if [ ! -f ~/.gitconfig ]; then
  cp -i "$HOME/.dotfiles/git/gitconfig.tmp" $HOME/.gitconfig
fi

mkdir -p "${HOME}/local/bin"

# pecoのインストール
if ! type "peco" > /dev/null 2>&1; then

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
    fi

    if [ -n $DL_URL ]; then
      wget "${BASE_URL}/${PECO_VER}/${DL_DIR}.tar.gz"
      if [ $? -eq 0 ]; then
        mkdir "${HOME}/.peco"
        tar -zxvf "${DL_DIR}.tar.gz" -C "${HOME}/.peco" --strip-components 1
        cp "${HOME}/.peco/peco" "${HOME}/local/bin"
        rm -rf "${DL_DIR}.tar.gz" .peco
      else
        echo "Couldn't install peco"
      fi
    fi
  fi
fi

