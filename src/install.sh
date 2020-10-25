#!/bin/bash
set -e
echo ""

TARGET=$1
REPO_ROOT=$2

source "${REPO_ROOT}/src/lib.sh"

backup_dotfiles ${TARGET} ${REPO_ROOT}
create_symlink_of_dotfiles ${TARGET} ${REPO_ROOT}

