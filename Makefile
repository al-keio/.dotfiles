all: except_shell

.PHONY: bash zsh fish

except_shell: 
	./install.sh

zsh:
	zsh zsh/install.sh
