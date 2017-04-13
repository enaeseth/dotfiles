" Ack

map <leader>a :Ack! 

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" Ale

let g:ale_javascript_flow_use_global = 1

" Airline
let g:airline_powerline_fonts = 0
let g:airline_theme = 'solarized'

let g:airline#extensions#ale#error_symbol = '◈'
let g:airline#extensions#ale#warning_symbol = '☇'

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


" YankRing

function! YRRunAfterMaps()
    nnoremap Y :<C-U>YRYankCount 'y$'<CR>
    omap <expr> L YRMapsExpression("", "$")
    omap <expr> H YRMapsExpression("", "^")
endfunction


