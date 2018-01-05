.PHONY: local update vundle uninstall vscode-update vscode-save

VIM ?= vim

VSCODE := $(HOME)/Library/Application\ Support/Code/User

INSTALLED := $(HOME)/.ackrc \
	$(HOME)/.emacs.d \
	$(HOME)/.gitconfig \
	$(HOME)/.inputrc \
	$(HOME)/.resources \
	$(HOME)/.ssh/config \
	$(HOME)/.tmux.conf \
	$(HOME)/.config/nvim \
	$(HOME)/.vim \
	$(HOME)/.vimrc \
	$(HOME)/.zlogin \
	$(HOME)/.zlogout \
	$(HOME)/.zprezto \
	$(HOME)/.zpreztorc \
	$(HOME)/.zprofile \
	$(HOME)/.zshenv \
	$(HOME)/.zshrc \
	$(VSCODE)/settings.json

TARGETS := $(INSTALLED) \
	local \
	vim/bundle \
	vim/bundle/Vundle.vim \
	vim/tmp/backup \
	vim/tmp/swap \
	vim/tmp/undo \
	vundle \
	zprezto \
	zprezto/modules/prompt/functions/prompt_eric_setup

all: $(TARGETS)

vscode-save:
	code --list-extensions | sort --ignore-case > vscode/extensions.txt

vscode-update:
	xargs -n 1 code --install-extension < vscode/extensions.txt

vim/tmp/backup: vim/tmp
vim/tmp/swap: vim/tmp
vim/tmp/undo: vim/tmp

vim/%:
	@mkdir -p $@

local:
	@$(MAKE) -C $@

$(VSCODE):
	mkdir -p "$@"

$(HOME)/.config/%: %
	@[ -d $(HOME)/.config ] || mkdir $(HOME)/.config
	@! [ -e $@ ] || [ -h $@ ] || ( echo >&2 '$@ exists'; exit 1 )
	ln -fns $(realpath $<) $@

$(HOME)/.%: %
	@! [ -e $@ ] || [ -h $@ ] || ( echo >&2 '$@ exists'; exit 1 )
	ln -fns $(realpath $<) $@

$(VSCODE)/settings.json: vscode/settings.json $(VSCODE)
	@[ ! -e "$@" ] || [ -h "$@" ] || ( echo >&2 '$@ exists'; exit 1 )
	ln -fns $(realpath $<) "$@"


$(HOME)/.ssh/config: ssh_config
	[ -d $(HOME)/.ssh ] || mkdir $(HOME)/.ssh
	@! [ -e $@ ] || [ -h $@ ] || ( echo >&2 '$@ exists'; exit 1 )
	ln -fns $(realpath $<) $@

$(HOME)/.gitconfig: gitconfig local/name local/email local/github
	sed \
		-e "s/{name}/$$(cat local/name)/" \
		-e "s/{email}/$$(cat local/email)/" \
		-e "s/{github}/$$(cat local/github)/" \
		$< > $@

update:
	$(VIM) '+PluginInstall!' '+qall'
	(cd zprezto; git pull --rebase)

vundle: vim/bundle/.ready

vim/bundle/.ready: vim/bundle/Vundle.vim
	[ "$$TERM" = unknown ] || $(VIM) '+PluginInstall' '+qall'
	touch $@

vim/bundle/Vundle.vim: vim/bundle
	[ -d $@ ] || git clone git://github.com/gmarik/Vundle.vim.git $@

zprezto:
	[ -d $@ ] || git clone --recursive git://github.com/sorin-ionescu/prezto $@

zprezto/modules/prompt/functions/prompt_eric_setup: prompt.zsh
	ln -fns $(realpath $<) $@

uninstall:
	rm $(INSTALLED)
