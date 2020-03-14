all: etc zsh

.PHONY: etc bash zsh peco

etc:
	etc/install.sh

bash:
	bash bash/install.sh

zsh:
	zsh zsh/install.sh

peco:
	etc/install-peco.sh
