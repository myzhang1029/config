syntax on
filetype plugin indent on

set autoread " Reload on change externally
set backspace=indent,eol,start " Enable backspace
set encoding=utf8
set hid
set list " Highlight invisible characters
set listchars=tab:▸\ ,eol:¬
set mouse=ncv
set nu       " Show line number
set ruler

" Try saving with sudo
command Wsuper execute 'w !sudo tee % > /dev/null' <bar> edit!
" Delete the current file https://stackoverflow.com/a/16679182
command DelFile call delete(expand('%')) | bdelete!
" Show edits
command Diff execute 'w !git diff --no-index -- % -'

" Don't mess up YAMLs
autocmd FileType yaml set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType yaml set indentkeys-=<:>
" Use actual tab chars in Makefiles and TSV.
autocmd FileType make set noexpandtab
autocmd BufEnter *.tsv set noexpandtab
" For everything else, use a tab width of 4
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
" Line wrap in diff
au VimEnter * if &diff | execute 'windo set wrap' | endif

" Remember file position
augroup resCur
    autocmd!
    autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

" Plugins
if has('nvim')
    call plug#begin('~/.config/nvim/plugged')
else
    call plug#begin('~/.config/vim/plugged')
endif

" TOML
Plug 'cespare/vim-toml'

" Swift
Plug 'keith/swift.vim'
Plug 'arzg/vim-swift'

" Safer modelines
Plug 'ciaranm/securemodelines'

" OpenCL
Plug 'petRUShka/vim-opencl'

" ARM assembler
Plug 'ARM9/arm-syntax-vim'

" GitHub copilot
Plug 'github/copilot.vim'

" Code time
Plug 'wakatime/vim-wakatime'

call plug#end()

" Mappings
" Emacs-style Ctrl-A to cure muscle memory
map <C-A> 0
" Let Ctrl-S do the job
noremap <C-S> <C-A>
