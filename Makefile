all: etc zsh vim

.PHONY: etc bash zsh

etc:
	etc/install.sh

etc_clean:
	etc/install.sh

bash:
	bash bash/install.sh

bash_clean:
	bash bash/uninstall.sh

zsh:
	zsh zsh/install.sh

zsh_clean:
	zsh zsh/uninstall.sh

%.sh:
	build_tools/$@

clean:
	etc_clean bash_clean zsh_clean
