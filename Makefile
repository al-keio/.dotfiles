all: etc zsh

.PHONY: etc zsh peco

etc: 
	etc/install.sh

zsh:
	zsh zsh/install.sh

peco:
	etc/install-peco.sh
