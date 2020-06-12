" Vundle
set nocompatible 
filetype off 

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Vundle, the plug-in manager for Vim.
Plugin 'VundleVim/Vundle.vim'

" lean & mean status/tabline for vim that's light as air.
Plugin 'vim-airline/vim-airline'

" A Vim plugin which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
Plugin 'airblade/vim-gitgutter'

" A collection of themes for vim-airline.
Plugin 'vim-airline/vim-airline-themes'

" A code-completion engine for Vim
Plugin 'ycm-core/YouCompleteMe'

" Auto close parentheses and repeat by dot dot dot...
Plugin 'cohama/lexima.vim'

" A tree explorer plugin for vim.
Plugin 'preservim/nerdtree'

" An arctic, north-bluish clean and elegant Vim theme.
Plugin 'arcticicestudio/nord-vim'

" A plugin of NERDTree showing git status.
Plugin 'Xuyuanp/nerdtree-git-plugin'

" A vim plugin to display the indention levels with thin vertical lines.
Plugin 'Yggdroot/indentLine'

" The best PostgreSQL plugin for Vim!
Plugin 'lifepillar/pgsql.vim'

" dadbod.vim: Modern database interface for Vim.
Plugin 'tpope/vim-dadbod'

" A Filetype plugin for csv files.
Plugin 'chrisbra/csv.vim'

" Toolkit for managing docker containers in vim.
Plugin 'kkvh/vim-docker-tools'

" fugitive.vim: A Git wrapper so awesome, it should be illegal.
Plugin 'tpope/vim-fugitive'

" Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP, unite, Denite, lightline, vim-startify and many more.
" This should always be last.
Plugin 'ryanoasis/vim-devicons'
call vundle#end()

filetype plugin indent on

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

set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start

set number
set updatetime=1
set cursorline

syntax enable

" Vimspector config
let g:vimspector_enable_mappings = 'HUMAN'
packadd! vimspector

" Gitgutter config
"hi Visual ctermfg=grey ctermbg=black
hi GitGutterAdd guifg=#009900 ctermfg=2
hi GitGutterChange guifg=#bbbb00 ctermfg=3
hi GitGutterDelete guifg=#ff2222 ctermfg=1

"hi SignColumn ctermbg=0


" vim-airline config
let g:airline_powerline_fonts = 1
let g:airline_theme='nord'
let g:airline#extensions#tabline#enabled = 1


set encoding=utf-8

" NERDTree config
let NERDTreeIgnore=[]
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>

" pgsql config
let g:sql_type_default = 'pgsql'

" Nord config

let g:nord_cursor_line_number_background = 1
let g:nord_bold = 1
"let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1

colorscheme nord
