.PHONY: update vundle uninstall

VIM ?= vim

INSTALLED := $(HOME)/.ackrc \
	$(HOME)/.gitconfig \
	$(HOME)/.inputrc \
	$(HOME)/.resources \
	$(HOME)/.ssh/config \
	$(HOME)/.tmux.conf \
	$(HOME)/.vim \
	$(HOME)/.vimrc \
	$(HOME)/.zlogin \
	$(HOME)/.zlogout \
	$(HOME)/.zprezto \
	$(HOME)/.zpreztorc \
	$(HOME)/.zprofile \
	$(HOME)/.zshenv \
	$(HOME)/.zshrc

TARGETS := $(INSTALLED) \
	vim/bundle \
	vim/bundle/Vundle.vim \
	vim/tmp \
	vim/tmp/backup \
	vim/tmp/swap \
	vim/tmp/undo \
	vundle

all: $(TARGETS)

vim/tmp/backup: vim/tmp
vim/tmp/swap: vim/tmp
vim/tmp/undo: vim/tmp

vim/%:
	mkdir $@

local:
	mkdir $@

$(HOME)/.%: %
	@! [ -e $@ ] || [ -h $@ ] || ( echo >&2 '$@ exists'; exit 1 )
	ln -fns $(realpath $<) $@

local/email: local
	@read -p 'What is your email address? ' email; echo "$$email" > $@

$(HOME)/.ssh/config: $(HOME)/.ssh/

$(HOME)/.gitconfig: gitconfig local/email
	sed "s/{email}/$$(cat local/email)/" $< > $@

update:
	$(VIM) '+PluginInstall!' '+qall'

vundle: vim/bundle/.ready

vim/bundle/.ready: vim/bundle/Vundle.vim
	$(VIM) '+PluginInstall' '+qall'
	touch $@

vim/bundle/Vundle.vim: vim/bundle
	[ -d $@ ] || git clone git://github.com/gmarik/Vundle.vim.git $@

uninstall:
	rm $(INSTALLED)
