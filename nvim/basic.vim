filetype plugin indent on

" Basic options

set encoding=utf-8                  " Use the only sane encoding choice
set modelines=2                     " Check 2 lines of files for commands
set autoindent                      " Continue previous line's indent by default
set showmode                        " Show mode in last line
set showcmd                         " Show visual selection size in last line
set hidden                          " Don't unload abandoned buffers
set visualbell                      " Use the visual bell instead of beeping
set cursorline                      " Highlight the entire line the cursor is on
set ttyfast                         " Assume a fast terminal connection
set ruler                           " Show cursor position
set backspace=indent,eol,start      " Sane edge case behavior for Backspace key
set relativenumber                  " Use relative line numbering
set laststatus=2                    " Show a status line for all windows always
set history=1000                    " Size of command and search pattern history
set undofile                        " Store undo history persistently on disk
set undoreload=10000                " Save the whole buffer for undo
set list                            " Show invisible characters
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set shell=/bin/zsh                  " Override default shell
set matchtime=3                     " Auto-highlight '%' match for 0.3s
set showbreak=↪                     " Use this character to indicate wrapping
set splitbelow                      " Default horizontal splits to appear below
set splitright                      " Default vertical splits to appear at right
set fillchars=diff:⣿                " Fill deleted diff lines in clearly
set autowrite                       " Write modified files on certain commands
set shiftround                      " Round indents to multiple of shiftwidth
set title                           " Update the (terminal) window title
set linebreak                       " Break lines at opportune characters
set nojoinspaces                    " Don't use two spaces between sentences (gq)
set dictionary=/usr/share/dict/words

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

" Completion settings
set completeopt=menu

" Wildmenu completion

set wildmenu
set wildmode=list:longest

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=TAGS                             " Ctags
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit

set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.pyc                            " Python byte code

set wildignore+=node_modules                     " that Node, Node Node Node
set wildignore+=npm-debug.log

set wildignore+=*.orig                           " Merge resolution files

set wildignore+=build

" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"

" Tabs, spaces, wrapping

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
set textwidth=80
set formatoptions+=tcrqnb
set formatoptions-=o
set colorcolumn=+1

" Leader

let mapleader = ","
let maplocalleader = "\\"

" Color scheme

syntax on
set background=dark
colorscheme solarized

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

set scrolloff=3
set sidescroll=1
set sidescrolloff=10

set virtualedit+=block
