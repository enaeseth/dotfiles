filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

set nocompatible

set modelines=0

let g:current_buffer_number=0

autocmd BufEnter * let g:current_buffer_number=bufnr('%')

function! GetCurrentIndicator()
	if bufnr('%') == g:current_buffer_number
		return '➜ '
	else
		return ''
	endif
endfunction

" Use a custom status-line, highlighted with the Solarized colors.
" Status from Fugitive and Syntastic are added, if those plugins are available.
function! ConfigureStatusLine()
	hi User1 guifg=#268bd2 guibg=#073642
	hi User2 guifg=#2aa198 guibg=#073642
	hi User3 guifg=#b58900 guibg=#073642
	hi User4 guifg=#d33682 guibg=#073642
	hi User5 gui=bold guifg=#859900 guibg=#073642

	set statusline=%<%5*%{GetCurrentIndicator()}%*%1*%f%*\ %h%3*%m%*%r
	if exists('g:loaded_fugitive')
		set statusline+=\ %2*%{fugitive#statusline()}%*
	endif
	set statusline+=\ %4*%y%*
	if exists('g:loaded_syntastic_plugin')
		set statusline+=\ %#warningmsg#%{SyntasticStatuslineFlag()}%*
	endif
	set statusline+=%=%-14.(%l,%c%V%)\ %P
endfunction

function! AutoOpenNERDTree()
	if has('gui_running') && argc() == 0
		:NERDTree
	endif
endfunction

function! AutoFocusAwayFromNERDTree()
	if has('gui_running') && argc() == 0
		:wincmd l
	endif
endfunction

autocmd GUIEnter * call AutoOpenNERDTree()
autocmd VimEnter * call AutoFocusAwayFromNERDTree()
autocmd ColorScheme * call ConfigureStatusLine()

set background=dark
colorscheme solarized

set tabstop=4
set shiftwidth=4
set softtabstop=4
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set undofile
set colorcolumn=+1
set textwidth=100

autocmd FileType html setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType htmldjango setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType javascript setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType php setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType yaml setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType coffee setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType css setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType gitcommit setlocal expandtab shiftwidth=4 softtabstop=4 textwidth=70

set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set undodir=~/.vim/tmp/undo//     " undo files
set backup                        " enable backups

if has('gui_running')
	" Turn off GUI elements
	set go-=T
	set guifont=Menlo\ Regular:h12
endif

let mapleader = ","

let NERDTreeIgnore=['\.o$', '\.pyc$', '\~$', 'TAGS$']
let NERDTreeSortOrder=['*', '\.swp$', '\.bak$', '\~$']

let g:CommandTMaxHeight = 15

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set list
set listchars=tab:▸\ ,eol:¬

"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
nnoremap <up> gk
nnoremap <down> gj
nnoremap <left> h
nnoremap <right> l
nnoremap j gj
nnoremap k gk

nnoremap <f13> :cp<cr>
nnoremap <f14> :cc<cr>
nnoremap <f15> :cn<cr>

" nnoremap ; :

" automatically save files when vim loses focus
au FocusLost * silent! :wa

" ,/ to invert comment on the current line/selection
nmap <leader>/ :call NERDComment(0, "invert")<cr>
vmap <leader>/ :call NERDComment(0, "invert")<cr>

" syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" delimitMate
let g:delimitMate_expand_space = 0
let g:delimitMate_expand_cr = 1

" conque
nmap <leader>s :ConqueTerm zsh<CR>
nmap <leader>r :ConqueTerm
let g:ConqueTerm_SendVisKey = '`<C-s>`'

" Ctrl-E to switch between 2 last buffers
nmap <C-E> :b#<CR>

" ,T to Display the file browser tree
nmap <leader>T :NERDTreeToggle<CR>
" ,p to show current file in the tree
nmap <leader>p :NERDTreeFind<CR>

" Gundo
nnoremap <leader>u :GundoToggle<CR>

" Fugitive commands
nmap <leader>g :Git 
nmap <leader>s :Gstatus<CR>6G
nmap <leader>c :Gcommit -v<CR>
nmap <leader>l :Glog<CR>
nmap <leader>d :Gdiff<CR>

nnoremap <leader>S :%s/\v\s+$//<cr>:let @/=''<CR>
nnoremap <leader>a :Ack 
nnoremap <leader>ft Vatzf
nnoremap <leader>q gqip
nnoremap <leader>v V`]

nnoremap <leader><right> <C-w>v<C-w>l
nnoremap <leader><down> <C-w>s<C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

map <D-1> :tabn 1<CR>
map <D-2> :tabn 2<CR>
map <D-3> :tabn 3<CR>
map <D-4> :tabn 4<CR>
map <D-5> :tabn 5<CR>
map <D-6> :tabn 6<CR>
map <D-7> :tabn 7<CR>
map <D-8> :tabn 8<CR>
map <D-9> :tabn 9<CR>

map! <D-1> <C-O>:tabn 1<CR>
map! <D-2> <C-O>:tabn 2<CR>
map! <D-3> <C-O>:tabn 3<CR>
map! <D-4> <C-O>:tabn 4<CR>
map! <D-5> <C-O>:tabn 5<CR>
map! <D-6> <C-O>:tabn 6<CR>
map! <D-7> <C-O>:tabn 7<CR>
map! <D-8> <C-O>:tabn 8<CR>
map! <D-9> <C-O>:tabn 9<CR>
