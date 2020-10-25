#!/bin/bash
set -e
echo ""

TARGET=$1
REPO_ROOT=$2

source "${REPO_ROOT}/src/lib.sh"

restore_dotfiles ${TARGET} ${REPO_ROOT}

print_title_debug "${TARGET}: remove cache files"
set -x
rm -rf ${REPO_ROOT}/cache/${TARGET}
{ set +x; } 2>/dev/null

