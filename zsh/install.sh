#!/bin/zsh

TARGET=$1
REPO_ROOT=$2

source "${REPO_ROOT}/src/lib.sh"

# install zinit and plugins
source "${REPO_ROOT}/${TARGET}/zinit_plugins"

