all: etc zsh

.PHONY: etc zsh

etc: 
	etc/install.sh

zsh:
	zsh zsh/install.sh
