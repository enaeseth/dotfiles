" .vimrc

" Source: https://github.com/enaeseth/dotfiles/blob/master/vimrc
"
" Largely based on Steve Losh's .vimrc, from his blog post "Coming Home to Vim",
" and the dotfile at https://bitbucket.org/sjl/dotfiles/src/tip/vim/.vimrc

filetype off
filetype plugin indent on
set nocompatible

" Vundle internals

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Color schemes

Bundle 'altercation/vim-colors-solarized'

" Language support

Bundle 'Jinja'
Bundle 'StanAngeloff/php.vim'
Bundle 'alunny/pegjs-vim'
Bundle 'digitaltoad/vim-jade'
Bundle 'groenewege/vim-less'
Bundle 'kchmck/vim-coffee-script'
Bundle 'othree/html5.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'timcharper/textile.vim'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'vim-ruby/vim-ruby'

" Life improvement

Bundle 'Raimondi/delimitMate'
Bundle 'ervandew/supertab'
Bundle 'git://git.wincent.com/command-t'
Bundle 'git@github.com:enaeseth/vim-powerline.git'
Bundle 'groenewege/vim-less'
Bundle 'henrik/vim-indexed-search'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'spiiph/vim-space'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'YankRing.vim'

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

set wildignore+=*.orig                           " Merge resolution files

set wildignore+=build

" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"

augroup basic
    au!

    " Save when losing focus
    au FocusLost * :silent! wall

    " Resize splits when the window is resized
    au VimResized * :wincmd =
augroup END

" Show trailing whitespace, but not in insert mode
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:·
    au InsertLeave * :set listchars+=trail:·
augroup END

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

" Backups

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" Leader

let mapleader = ","
let maplocalleader = "\\"

" Color scheme

syntax on
set background=dark
colorscheme solarized

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'


" Status line ----------------------------------------------------------------------------------

let g:Powerline_symbols = 'fancy'
let g:Powerline_colorscheme = 'solarized256'

" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

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

noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Heresy
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A

" Ack for the last search.
nnoremap <silent> <leader>? :execute "Ack! '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>

" Error navigation
"
"             Location List     QuickFix Window
"            (e.g. Syntastic)     (e.g. Ack)
"            ----------------------------------
" Next      |     M-k               M-Down     |
" Previous  |     M-l                M-Up      |
"            ----------------------------------
"
nnoremap ˚ :lnext<cr>zvzz
nnoremap ¬ :lprevious<cr>zvzz
inoremap ˚ <esc>:lnext<cr>zvzz
inoremap ¬ <esc>:lprevious<cr>zvzz
nnoremap <m-Down> :cnext<cr>zvzz
nnoremap <m-Left> :cc<cr>zvzz
nnoremap <m-Up> :cprevious<cr>zvzz

" Directional Keys

noremap j gj
noremap k gk

" Easy buffer navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

" Visual Mode */# from Scrooloose
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

" Fuck you, help key.
noremap  <F1> :set invfullscreen<CR>
inoremap <F1> <ESC>:set invfullscreen<CR>a

" Fuck you too, manual key.
nnoremap K <nop>

" Stop it, hash key.
inoremap # X<BS>#

" File types -----------------------------------------------------------------------------------

" C

augroup ft_c
    au!
    au FileType c setlocal foldmethod=syntax
augroup END

" CoffeeScript
augroup ft_coffee
    au!

    au FileType coffee setlocal shiftwidth=2 softtabstop=2
augroup END
" CSS and Less

augroup ft_css
    au!

    au BufNewFile,BufRead *.less setlocal filetype=less

    au Filetype less,css setlocal omnifunc=csscomplete#CompleteCSS
    au Filetype less,css setlocal iskeyword+=-

    au FileType css setlocal shiftwidth=2 softtabstop=2
    au FileType less setlocal shiftwidth=4 softtabstop=4
augroup END

" HTML and HTMLDjango

augroup ft_html
    au!

    au BufNewFile,BufRead *.html setlocal filetype=htmldjango
    au FileType html,jinja,htmldjango setlocal foldmethod=manual
    au Filetype html,jinja,htmldjango setlocal iskeyword+=-

    " Use <leader>f to fold the current tag.
    au FileType html,jinja,htmldjango nnoremap <buffer> <leader>f Vatzf

    " Use Shift-Return to turn this:
    "     <tag>|</tag>
    "
    " into this:
    "     <tag>
    "         |
    "     </tag>
    au FileType html,jinja,htmldjango nnoremap <buffer> <s-cr> vit<esc>a<cr><esc>vito<esc>i<cr><esc>

    " Django tags
    au FileType jinja,htmldjango inoremap <buffer> <c-t> {%<space><space>%}<left><left><left>

    " Django variables
    au FileType jinja,htmldjango inoremap <buffer> <c-f> {{<space><space>}}<left><left><left>
augroup END

" Git commit

augroup ft_gitcommit
    au!

    autocmd FileType gitcommit setlocal textwidth=70 spell nonumber norelativenumber
augroup END

" Javascript

augroup ft_javascript
    au!

    au FileType javascript setlocal foldmethod=manual
augroup END

" Markdown

augroup ft_markdown
    au!

    au BufNewFile,BufRead *.m*down setlocal filetype=markdown

    " Use <localleader>1/2/3 to add headings.
    au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=
    au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-
    au Filetype markdown nnoremap <buffer> <localleader>3 I### <ESC>
augroup END

" Nginx

augroup ft_nginx
    au!

    au BufRead,BufNewFile /etc/nginx/conf/*                      set ft=nginx
    au BufRead,BufNewFile /etc/nginx/sites-available/*           set ft=nginx
    au BufRead,BufNewFile /usr/local/etc/nginx/sites-available/* set ft=nginx
    au BufRead,BufNewFile vhost.nginx                            set ft=nginx

    au FileType nginx setlocal foldmethod=marker foldmarker={,}
augroup END

" OrgMode

augroup ft_org
    au!

    au Filetype org nmap <buffer> Q vahjgq
augroup END

" PHP
augroup ft_php
    au!

    au FileType php setlocal textwidth=100
    au FileType php setlocal foldmethod=syntax
augroup END
" Puppet

augroup ft_puppet
    au!

    au Filetype puppet setlocal foldmethod=marker
    au Filetype puppet setlocal foldmarker={,}
augroup END

" Python

augroup ft_python
    au!

    au FileType python setlocal omnifunc=pythoncomplete#Complete
    au FileType python setlocal define=^\s*\\(def\\\\|class\\)
    au FileType man nnoremap <buffer> <cr> :q<cr>
augroup END

" QuickFix

augroup ft_quickfix
    au!
    au Filetype qf setlocal colorcolumn=0 nolist nocursorline nowrap
augroup END

" ReStructuredText

augroup ft_rest
    au!

    au Filetype rst nnoremap <buffer> <localleader>1 yypVr=
    au Filetype rst nnoremap <buffer> <localleader>2 yypVr-
    au Filetype rst nnoremap <buffer> <localleader>3 yypVr~
    au Filetype rst nnoremap <buffer> <localleader>4 yypVr`
augroup END

" Ruby

augroup ft_ruby
    au!
    au Filetype ruby setlocal foldmethod=syntax shiftwidth=2 softtabstop=2
augroup END

" Vim

augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

" YAML

augroup ft_yaml
    au!
    au FileType yaml setlocal shiftwidth=2 softtabstop=2
augroup END

"
" Quick editing --------------------------------------------------------------------------------

nnoremap <leader>ev <C-w>s<C-w>j<C-w>L:e $MYVIMRC<cr>

" Convenience mappings -------------------------------------------------------------------------

" Opening splits
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>W <C-w>s<C-w>j

nnoremap <leader><left> <C-w>v
nnoremap <leader><right> <C-w>v<C-w>l
nnoremap <leader><up> <C-w>s
nnoremap <leader><down> <C-w>s<C-w>j

" Clean whitespace
map <leader>h :%s/\s\+$//<cr>:let @/=''<cr>

" I constantly hit "u" in visual mode when I mean to "y". Use "gu" for those rare occasions.
" From https://github.com/henrik/dotfiles/blob/master/vim/config/mappings.vim
vnoremap u <nop>
vnoremap gu u

" Send visual selection to gist.github.com as a private, filetyped Gist
" Requires the gist command line too (brew install gist)
vnoremap <leader>G :w !gist -p -t %:e \| pbcopy<cr>

" Change case
nnoremap <C-u> gUiw
inoremap <C-u> <esc>gUiwea

" Substitute
nnoremap <leader>s :%s//<left>

" Switch to previous buffer
nmap <C-E> :b#<CR>

" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Insert the directory of the current buffer in command line mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'>

" Formatting, TextMate-style
nnoremap Q gqip

" Marks and Quotes
noremap ' `
noremap æ '
noremap ` <C-^>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Toggle paste
set pastetoggle=<F8>

" Handle URL
" Stolen from https://github.com/askedrelic/homedir/blob/master/.vimrc
" OSX only: Open a web-browser with the URL in the current line
function! HandleURI()
    let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
    echo s:uri
    if s:uri != ""
        exec "!open \"" . s:uri . "\""
    else
        echo "No URI found in line."
    endif
endfunction
map <leader>U :call HandleURI()<CR>

" Quickreturn
inoremap <c-cr> <esc>A<cr>
inoremap <s-cr> <esc>A:<cr>

" Insert Mode Completion

inoremap <c-l> <c-x><c-l>
inoremap <c-f> <c-x><c-f>


" Plugin settings ------------------------------------------------------------------------------

" Ack

map <leader>a :Ack! 

" Command-T
let g:CommandTMaxHeight = 5
let g:CommandTMatchWindowReverse = 1

nnoremap <leader>c :CommandTFlush<cr>

" Fugitive

nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>
nnoremap <leader>gl :Shell git gl -18<cr>:wincmd \|<cr>

augroup ft_fugitive
    au!

    au BufNewFile,BufRead .git/index setlocal nolist
augroup END

" Gundo

nnoremap <leader>u :GundoToggle<CR>
let g:gundo_preview_bottom = 1

" HTML5

let g:event_handler_attributes_complete = 0
let g:rdfa_attributes_complete = 0
let g:microdata_attributes_complete = 0
let g:atia_attributes_complete = 0

" NERDTree

nmap <leader>T :NERDTreeToggle<CR>
nmap <leader>p :NERDTreeFind<CR>

au Filetype nerdtree setlocal nolist

let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index', 'xapian_index', '.*.pid', 'monitor.py', '.*-fixtures-.*.json', '.*\.o$', 'db.db']

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

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

" Supertab

let g:SuperTabDefaultCompletionType = "<c-p>"
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1

"}}}
" Syntastic

let g:syntastic_enable_signs = 1
let g:syntastic_disabled_filetypes = ['html']
let g:syntastic_stl_format = '[%E{Error 1/%e :%fe}%B{, }%W{Warning 1/%w :%fw}]'
let g:syntastic_jsl_conf = '$HOME/.vim/jsl.conf'
let g:syntastic_auto_loc_list = 1

" YankRing

function! YRRunAfterMaps()
    nnoremap Y :<C-U>YRYankCount 'y$'<CR>
    omap <expr> L YRMapsExpression("", "$")
    omap <expr> H YRMapsExpression("", "^")
endfunction


" Text objects ---------------------------------------------------------------------------------

" Shortcut for []

onoremap id i[
onoremap ad a[
vnoremap id i[
vnoremap ad a[

" Next and Last

" Motion for "next/last object". For example, "din(" would go to the next "()" pair
" and delete its contents.

onoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>

onoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
xnoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
onoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>
xnoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>

function! s:NextTextObject(motion, dir)
  let c = nr2char(getchar())

  if c ==# "b"
      let c = "("
  elseif c ==# "B"
      let c = "{"
  elseif c ==# "d"
      let c = "["
  endif

  exe "normal! ".a:dir.c."v".a:motion.c
endfunction


" Ack motions -------------------------------------------------------------

" Motions to Ack for things.  Works with pretty much everything, including:
"
"   w, W, e, E, b, B, t*, f*, i*, a*, and custom text objects
"
" Awesome.
"
" Note: If the text covered by a motion contains a newline it won't work.  Ack
" searches line-by-line.

nnoremap <silent> \a :set opfunc=<SID>AckMotion<CR>g@
xnoremap <silent> \a :<C-U>call <SID>AckMotion(visualmode())<CR>

function! s:CopyMotionForType(type)
    if a:type ==# 'v'
        silent execute "normal! `<" . a:type . "`>y"
    elseif a:type ==# 'char'
        silent execute "normal! `[v`]y"
    endif
endfunction

function! s:AckMotion(type) abort
    let reg_save = @@

    call s:CopyMotionForType(a:type)

    execute "normal! :Ack! --literal " . shellescape(@@) . "\<cr>"

    let @@ = reg_save
endfunction

" Utils -------------------------------------------------------------------

" Synstack

" Show the stack of syntax hilighting classes affecting whatever is under the
" cursor.
function! SynStack() "{{{
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " ❯ ")
endfunc "}}}

nnoremap ß :call SynStack()<CR>

" Toggle whitespace in diffs

set diffopt-=iwhite
let g:diffwhitespaceon = 1
function! ToggleDiffWhitespace() "{{{
    if g:diffwhitespaceon
        set diffopt-=iwhite
        let g:diffwhitespaceon = 0
    else
        set diffopt+=iwhite
        let g:diffwhitespaceon = 1
    endif
    diffupdate
endfunc "}}}

nnoremap <leader>dw :call ToggleDiffWhitespace()<CR>


" Environments (GUI/Console) -------------------------------------------------------------------

if has('gui_running')
    set guifont=Menlo\ for\ Powerline:h12

    " Remove all the UI cruft
    set go-=T
    set go-=l
    set go-=L
    set go-=r
    set go-=R

    highlight SpellBad term=underline gui=undercurl guisp=Orange

    " Use a line-drawing char for pretty vertical splits.
    set fillchars+=vert:│

    " Different cursors for different modes.
    "set guicursor=n-c:block-Cursor-blinkon0
    "set guicursor+=v:block-vCursor-blinkon0
    "set guicursor+=i-ci:ver20-iCursor

    if has("gui_macvim")
        " Full screen means FULL screen
        set fuoptions=maxvert,maxhorz

        " Use the normal HIG movements, except for M-Up/Down
        let macvim_skip_cmd_opt_movement = 1
        no   <D-Left>       <Home>
        no!  <D-Left>       <Home>
        no   <M-Left>       <C-Left>
        no!  <M-Left>       <C-Left>

        no   <D-Right>      <End>
        no!  <D-Right>      <End>
        no   <M-Right>      <C-Right>
        no!  <M-Right>      <C-Right>

        no   <D-Up>         <C-Home>
        ino  <D-Up>         <C-Home>
        imap <M-Up>         <C-o>{

        no   <D-Down>       <C-End>
        ino  <D-Down>       <C-End>
        imap <M-Down>       <C-o>}

        imap <M-BS>         <C-w>
        inoremap <D-BS>     <esc>my0c`y
    else
        " Non-MacVim GUI, like Gvim
    end
else
    " Console Vim
endif
