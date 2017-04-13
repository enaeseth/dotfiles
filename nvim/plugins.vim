" Ack

map <leader>a :Ack! 

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

nnoremap <leader>c :CommandTFlush<cr>

" EditorConfig

let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'
let g:EditorConfig_core_mode = 'external_command'

" fuzzy

nnoremap <leader>p :FuzzyOpen<cr>

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
let NERDTreeIgnore=[
    \'\~$',
    \'.*\.py[co]$',
    \'__pycache__$',
    \'^_build$',
    \'pip-log\.txt$',
    \'whoosh_index',
    \'xapian_index',
    \'.*.pid',
    \'monitor.py',
    \'.*-fixtures-.*.json',
    \'.*\.o$',
    \'db.db',
    \'\.sqlite3$',
    \'\.egg-info$',
    \'node_modules$',
    \]

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


" Syntastic

let g:syntastic_enable_signs = 1
let g:syntastic_disabled_filetypes = ['html']
let g:syntastic_stl_format = '[%E{Error 1/%e :%fe}%B{, }%W{Warning 1/%w :%fw}]'
let g:syntastic_jsl_conf = '$HOME/.vim/jsl.conf'
let g:syntastic_auto_loc_list = 1
let g:syntastic_go_checkers = [''] " we use a golang plugin which does this
let g:syntastic_rst_checkers = ['rstcheck']

" YankRing

function! YRRunAfterMaps()
    nnoremap Y :<C-U>YRYankCount 'y$'<CR>
    omap <expr> L YRMapsExpression("", "$")
    omap <expr> H YRMapsExpression("", "^")
endfunction


