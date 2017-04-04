" C

augroup ft_c
    au!
    au FileType c setlocal foldmethod=manual
augroup END

" CoffeeScript
augroup ft_coffee
    au!

    au FileType coffee setlocal shiftwidth=2 softtabstop=2
    au BufRead,BufNewFile *.cson set ft=coffee
augroup END

" CSS, Sass, and Less

augroup ft_css
    au!

    au BufNewFile,BufRead *.less setlocal filetype=less

    au Filetype sass,less,css setlocal omnifunc=csscomplete#CompleteCSS
    au Filetype sass,less,css setlocal iskeyword+=-

    au FileType css setlocal shiftwidth=2 softtabstop=2
    au FileType sass setlocal shiftwidth=2 softtabstop=2
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

" Go (golang)
augroup ft_golang
    au!

    au FileType go setlocal listchars-=tab:▸\ 
    au FileType go setlocal listchars+=tab:\ \ 
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
augroup END

" Puppet

augroup ft_puppet
    au!

    au Filetype puppet setlocal foldmethod=manual
    au FileType puppet setlocal shiftwidth=4 softtabstop=4
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
    au Filetype ruby setlocal foldmethod=manual shiftwidth=2 softtabstop=2
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

