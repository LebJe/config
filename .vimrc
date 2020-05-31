
" Vundle
set nocompatible 
filetype off 

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" vim-airline
Plugin 'vim-airline/vim-airline'

" vim-gitgutter
Plugin 'airblade/vim-gitgutter'

" vim-airline themes
Plugin 'vim-airline/vim-airline-themes'

" async.vim
Plugin 'prabirshrestha/async.vim'

" vim-lsp
Plugin 'prabirshrestha/vim-lsp'

call vundle#end()
filetype plugin indent on

" Personal config
syntax on

colorscheme slate

set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start

set background=dark
set number
set updatetime=1

" vim-airline config
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'

" Gitgutter config
hi LineNr ctermfg=grey
hi Visual ctermfg=grey ctermbg=black
hi GitGutterAdd guifg=#009900 ctermfg=2
hi GitGutterChange guifg=#bbbb00 ctermfg=3
hi GitGutterDelete guifg=#ff2222 ctermfg=1
hi SignColumn ctermbg=0

" vim-lsp config
if executable('sourcekit-lsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'sourcekit-lsp',
        \ 'cmd': {server_info->['sourcekit-lsp']},
        \ 'whitelist': ['swift'],
        \ })
endif

autocmd FileType * setlocal omnifunc=lsp#complete
