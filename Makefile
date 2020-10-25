# Makefileのあるディレクトリ = repository root
ABS_MAKE := $(abspath $(lastword $(MAKEFILE_LIST)))
REPO_ROOT := $(shell echo $(ABS_MAKE) | sed -e "s/\/Makefile//g")

all: etc bash zsh

.PHONY: etc bash zsh

etc bash zsh:
	@echo
	$@/install.sh $@ ${REPO_ROOT}
	@echo
	src/install.sh $@ ${REPO_ROOT}

clean-etc clean-bash clean-zsh:
	@echo
	$(eval TARGET := $(subst clean-,,$@))
	$(TARGET)/uninstall.sh $(TARGET) ${REPO_ROOT}
	@echo
	src/uninstall.sh $(TARGET) ${REPO_ROOT}

clean: clean-etc clean-bash clean-zsh

