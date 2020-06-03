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

" YouCompleteMe
Plugin 'ycm-core/YouCompleteMe'

" lexima.vim
Plugin 'cohama/lexima.vim'
call vundle#end()

filetype plugin indent on

syntax on

" vim-airline config
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'

" YouCompleteMe config

let s:lsp = '~/.vim/lsp-examples'

let g:ycm_language_server = 
  \ [ 
  \   {
  \     'name': 'swift',
  \     'cmdline': [ 'sourcekit-lsp' ],
  \     'filetypes': [ 'swift' ]
  \   },
  \	  {
  \     'name': 'bash',
  \     'cmdline': [ 'node', expand( s:lsp . '/bash/node_modules/.bin/bash-language-server' ), 'start' ],
  \     'filetypes': [ 'sh', 'bash' ],
  \   },
  \   {
  \     'name': 'yaml',
  \     'cmdline': [ 'node', expand( s:lsp . '/yaml/node_modules/.bin/yaml-language-server' ), '--stdio' ],
  \     'filetypes': [ 'yaml' ],
  \   },
  \   {
  \     'name': 'json',
  \     'cmdline': [ 'node', expand( s:lsp . '/json/node_modules/.bin/vscode-json-languageserver' ), '--stdio' ],
  \     'filetypes': [ 'json' ],
  \   },
  \   { 'name': 'docker',
  \     'filetypes': [ 'dockerfile' ], 
  \     'cmdline': [ expand( s:lsp . '/docker/node_modules/.bin/docker-langserver' ), '--stdio' ]
  \   },
  \   { 'name': 'vim',
  \     'filetypes': [ 'vim' ],
  \     'cmdline': [ expand( s:lsp . '/viml/node_modules/.bin/vim-language-server' ), '--stdio' ]
  \   }
  \ ]

" Personal config

colorscheme slate

set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start

set background=dark
set number
set updatetime=1

" Gitgutter config
hi Visual ctermfg=grey ctermbg=black
hi GitGutterAdd guifg=#009900 ctermfg=2
hi GitGutterChange guifg=#bbbb00 ctermfg=3
hi GitGutterDelete guifg=#ff2222 ctermfg=1
hi SignColumn ctermbg=0


hi LineNr ctermfg=grey
set encoding=utf-8
