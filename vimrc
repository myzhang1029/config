syntax on
filetype plugin indent on

set autoread " Reload on change externally
set nu       " Show line number
set backspace=indent,eol,start " Enable backspace
set encoding=utf8
set mouse=ncv
set ruler
set hid

command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Don't mess up YAMLs
autocmd FileType yaml set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType yaml set indentkeys-=<:>
" Use actual tab chars in Makefiles.
autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
" For everything else, use a tab width of 4
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" Remember file position
augroup resCur
    autocmd!
    autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

