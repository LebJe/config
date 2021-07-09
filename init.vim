" Settings

set list lcs=tab:\▏\ 

fun! OpenTerminal()
	:tabe
	:Tcolorscheme nord
	:terminal
endfun

lua require('settings')
lua require('plugins')
lua require('pluginsSetup')

:map <leader>v :call OpenVista()<enter>
:map <leader>vw :Vista!!<enter>

fun! OpenVista()
    if &ft =~ 'markdown\|markdown'
    	:Vista toc
		return
    endif

	:Vista coc
endfun

"autocmd VimEnter * call OpenVista()

autocmd BufWinLeave * :Vista!

" vim-airline config
let g:airline_powerline_fonts = 1
let g:airline_theme='codedark'
let g:airline#extensions#whitespace#enabled = 0

let g:airline_left_sep=''
let g:airline_right_sep=''

let g:airline_exclude_filetypes = ['minimap', 'coc-explorer']
let g:airline_exclude_buftypes = ['minimap', 'coc-explorer']

" minimap.vim config
let g:minimap_width = 20
let g:minimap_git_colors = 1
hi MinimapCurrentLine ctermfg=Green guifg=#50FA7B guibg=#32302f
let g:minimap_highlight = 'MinimapCurrentLine'
let g:minimap_block_filetypes = ['coc-explorer']
let g:minimap_block_buftypes = ['nofile', 'nowrite', 'quickfix', 'terminal', 'prompt', 'coc-explorer']
let g:minimap_close_filetypes = ['startify', 'netrw', 'vim-plug', 'coc-explorer']

let g:minimap_auto_start = 0
