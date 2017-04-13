let $NVIM_TUI_ENABLE_TRUE_COLOR=1

call plug#begin('~/.local/share/nvim/plugged')

" Color schemes

Plug 'arakashic/nvim-colors-solarized'

" Language support

Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-markdown'
Plug 'groenewege/vim-less'
Plug 'flowtype/vim-flow', { 'for': 'javascript' }

" Life improvement

Plug 'junegunn/vim-easy-align'
Plug 'ervandew/supertab'
Plug 'michaeljsmith/vim-indent-object'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'sjl/gundo.vim'
Plug 'spiiph/vim-space'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/YankRing.vim'
Plug 'cloudhead/neovim-fuzzy'
Plug 'editorconfig/editorconfig-vim'

call plug#end()


runtime basic.vim
runtime map.vim
runtime plugins.vim
runtime types.vim
runtime auto.vim
runtime gui.vim
