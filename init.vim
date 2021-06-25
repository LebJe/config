" Vim-Plug plugins.
set nocompatible

" Install Vim-Plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install Plugins.
call plug#begin()
" plenary: full; complete; entire; absolute; unqualified. All the lua
" functions I don't want to write twice.
Plug 'nvim-lua/plenary.nvim'

" Git signs written in pure lua
Plug 'lewis6991/gitsigns.nvim', { 'tag': '*' }

" 📡 Blazing fast minimap for vim, powered by code-minimap written in Rust.
Plug 'wfxr/minimap.vim'

" Nvim Treesitter configurations and abstraction layer
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'

" 🌵 Viewer & Finder for LSP symbols and tag
Plug 'liuchengxu/vista.vim'

" A collection of themes for vim-airline.
Plug 'vim-airline/vim-airline-themes'

" Intellisense engine for Vim8 & Neovim, full language server protocol support as VSCode.
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

" Auto close parentheses and repeat by dot dot dot...
Plug 'cohama/lexima.vim'

" A Filetype plugin for csv files.
Plug 'chrisbra/csv.vim'

" Toolkit for managing docker containers in vim.
Plug 'kkvh/vim-docker-tools'

" fugitive.vim: A Git wrapper so awesome, it should be illegal.
Plug 'tpope/vim-fugitive'

" An arctic, north-bluish clean and elegant Vim theme.
Plug 'arcticicestudio/nord-vim'

" A Vim plugin that always highlights the enclosing html/xml tags.
Plug 'Valloric/MatchTagAlways'

" 🚀 Run Async Shell Commands in Vim 8.0 / NeoVim and Output to the Quickfix Window!
Plug 'skywind3000/asyncrun.vim'

" 🚀 Modern Task System for Project Building, Testing and Deploying
Plug 'skywind3000/asyncrun.vim'

" A better JSON for Vim: distinct highlighting of keywords vs values, JSON-specific (non-JS) warnings, quote concealing. Pathogen-friendly.
Plug 'elzr/vim-json'

" Vim runtime files for Swift.
Plug 'keith/swift.vim'

" vimspector - A multi-language debugging system for Vim.
Plug 'puremourning/vimspector'

" Vim colorscheme on each tabs
Plug 'ujihisa/tabpagecolorscheme'

" Dark color scheme for Vim and vim-airline, inspired by Dark+ in Visual Studio Code
Plug 'tomasiser/vim-code-dark'

" Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP, unite, Denite, lightline, vim-startify and many more.
" This should always be last.
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Personal config

set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start

set number
set updatetime=1
set cursorline

set background=dark

colorscheme codedark

" Mappings
tnoremap <Esc> <C-\><C-n>
" Run current Python file in terminal.
nnoremap rpy :CocCommand python.execInTerminal<enter>

" Run current Swift project in terminal.
nnoremap rsw :!swift run<enter>

" Build current Swift project.
nnoremap bsw :!swift build<enter>

" Resolve all packages for the current Swift project.
nnoremap spr :!swift package resolve<enter>

:map <c-t> :call OpenTerminal()<enter>
:map <leader>v :call OpenVista()<enter>
:map <leader>vw :Vista!!<enter>

" Settings
set encoding=utf-8
set termguicolors

set list lcs=tab:\▏\ 

fun! OpenTerminal()
	:tabe
	:Tcolorscheme nord
	:terminal
endfun

" gitsigns Config
hi GitSignsAdd guifg=#009900 ctermfg=2
hi GitSignsChange guifg=#bbbb00 ctermfg=3
hi GitSignsDelete guifg=#ff2222 ctermfg=1

" Vista.vim config

let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = 'coc'
let g:vista_sidebar_width = 50
"let g:vista_update_on_text_changed = 1
let g:vista_update_on_text_changed_delay = 100

let g:vista_executive_for = {
  \ 'vimwiki': 'markdown',
  \ 'markdown': 'toc',
\ }

fun! OpenVista()
    if &ft =~ 'markdown\|markdown'
    	:Vista toc
		return
    endif

	:Vista coc
endfun

"autocmd VimEnter * call OpenVista()

autocmd BufWinLeave * :Vista!

" Vimspector config
let g:vimspector_enable_mappings = 'HUMAN'

let g:vimspector_install_gadgets = ["vscode-python", "vscode-cpptools", "CodeLLDB"]

" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval

" vim-airline config
let g:airline_powerline_fonts = 1
let g:airline_theme='codedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0

let g:airline_left_sep=''
let g:airline_right_sep=''

let g:airline_exclude_filetypes = ['minimap', 'coc-explorer']
let g:airline_exclude_buftypes = ['minimap', 'coc-explorer']

" AsyncRun config
" Open quick fix window.
let g:asyncrun_open = 6

" csv.vim config
let b:csv_arrange_align = 'l*'

" Coc.nvim config

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.

let g:airline#extensions#coc#enabled = 1

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>)


let g:coc_global_extensions = [
\	"coc-json",
\	"coc-sql",
\	"coc-yaml",
\	"coc-vimlsp",
\	"coc-tsserver",
\	"coc-html",
\	"coc-css",
\	"coc-python",
\	"coc-go",
\	"coc-snippets",
\	"coc-prettier",
\	"coc-marketplace",
\	"coc-sh",
\	"coc-explorer",
\	"coc-spell-checker",
\	"coc-clangd",
\	"coc-rls"
\]

" Use <Tab> and <S-Tab> to navigate the completion list:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


noremap <C-n> :CocCommand explorer<CR>

" Use <Tab> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<Tab>'

" Use <S-Tab> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<S-Tab>'

" Format current buffer using :Prettier.
command! -nargs=0 Prettier :CocCommand prettier.formatFile

let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

let g:vim_json_syntax_conceal = 0

" Use preset argument to open it
nmap <space>ed :CocCommand explorer --preset .vim<CR>
nmap <space>ef :CocCommand explorer --preset floating<CR>

" List all presets
nmap <space>el :CocList explPresets

" minimap.vim config
let g:minimap_width = 20
let g:minimap_git_colors = 1
hi MinimapCurrentLine ctermfg=Green guifg=#50FA7B guibg=#32302f
let g:minimap_highlight = 'MinimapCurrentLine'
let g:minimap_block_filetypes = ['coc-explorer']
let g:minimap_block_buftypes = ['nofile', 'nowrite', 'quickfix', 'terminal', 'prompt', 'coc-explorer']
let g:minimap_close_filetypes = ['startify', 'netrw', 'vim-plug', 'coc-explorer']

let g:minimap_auto_start = 0

" TreeSitter Config
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"dockerfile", "python", "graphql", "html", "bash", "c", "javascript", "json", "css", "cpp", "c", "swift", "toml", "yaml", "go", "rust", "typescript"},
  highlight = {
    enable = true,
  },
}
EOF

" gitsigns Config

lua <<EOF
require('gitsigns').setup {
	current_line_blame_delay = 100,
	current_line_blame = true,
	sign_priority = 6,
	signs = {
    	add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    	change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    	delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    	topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    	changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  }
}
EOF

" CoC.nvim Config - Extended

hi! link CocSem_enum Type
hi! link CocSem_struct Type
hi! link CocSem_keyword Keyword
hi! link CocSem_function Function
hi! link CocSem_type Type
hi! link CocSem_variable Identifier
hi! link CocSem_parameter Label
hi! link CocSem_property Identifier
hi! link CocSem_namespace Type
hi! link CocSem_class Type
hi! link CocSem_method Function
hi! link CocSem_comment Comment
hi! link CocSem_enumMember Constant
