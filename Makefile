all: etc zsh vim

.PHONY: etc bash zsh

etc:
	etc/install.sh

bash:
	bash bash/install.sh

zsh:
	zsh zsh/install.sh

%.sh:
	build_tools/$@
