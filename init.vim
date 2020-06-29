" Vim-Plug plugins.
set nocompatible 

call plug#begin()
" lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'

" A Vim plugin which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
Plug 'airblade/vim-gitgutter'

" A collection of themes for vim-airline.
Plug 'vim-airline/vim-airline-themes'

" Intellisense engine for Vim8 & Neovim, full language server protocol support as VSCode.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Auto close parentheses and repeat by dot dot dot...
Plug 'cohama/lexima.vim'

" A vim plugin to display the indention levels with thin vertical lines.
Plug 'Yggdroot/indentLine'

" An arctic, north-bluish clean and elegant Vim theme.
Plug 'arcticicestudio/nord-vim'

" A plugin of NERDTree showing git status.
Plug 'Xuyuanp/nerdtree-git-plugin'

" The best PostgreSQL plugin for Vim!
Plug 'lifepillar/pgsql.vim'

" dadbod.vim: Modern database interface for Vim.
Plug 'tpope/vim-dadbod'

" A Filetype plugin for csv files.
Plug 'chrisbra/csv.vim'

" Toolkit for managing docker containers in vim.
Plug 'kkvh/vim-docker-tools'

" fugitive.vim: A Git wrapper so awesome, it should be illegal.
Plug 'tpope/vim-fugitive'

"  Vim runtime files for Swift.
Plug 'keith/swift.vim'

" A Vim plugin that always highlights the enclosing html/xml tags.
Plug 'Valloric/MatchTagAlways'

" 🚀 Run Async Shell Commands in Vim 8.0 / NeoVim and Output to the Quickfix Window!
Plug 'skywind3000/asyncrun.vim'

" 🚀 Modern Task System for Project Building, Testing and Deployin 
Plug 'skywind3000/asyncrun.vim'

" A better JSON for Vim: distinct highlighting of keywords vs values, JSON-specific (non-JS) warnings, quote concealing. Pathogen-friendly.
Plug 'elzr/vim-json'

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

" Open quick fix window.
let g:asyncrun_open = 6

" Run current Python file in terminal.
nnoremap rpy :CocCommand python.execInTerminal<enter>

" Run current Swift project in terminal.
nnoremap rsw :!swift run<enter>

" Build current Swift project.
nnoremap bsw :!swift build<enter>

" Resolve all packages for the current Swift project.
nnoremap spr :!swift build<enter>

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

" pgsql config
let g:sql_type_default = 'pgsql'

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

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
"      \ pumvisible( ? \"\<C-n>\" :
"      \ <SID>check_back_space() ? \"\<TAB>\" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? \"\<C-p>\" : \"\<C-h>\"

"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

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
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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


let g:coc_global_extensions = ["coc-json", "coc-sql", "coc-java", "coc-xml", "coc-yaml", "coc-vimlsp", "coc-tsserver", "coc-html", "coc-css", "coc-python", "coc-solargraph", "coc-go", "coc-emmet", "coc-snippets", "coc-prettier", "coc-marketplace", "coc-sh", "coc-java-debug", "coc-explorer"]

" Use <Tab> and <S-Tab> to navigate the completion list:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


noremap <C-n> :CocCommand explorer<CR>

" Use <S-Tab> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<Tab>'

" Use <S-Tab> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<S-Tab>'

" Format current buffer using :Prettier.
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Nord config

let g:nord_cursor_line_number_background = 1
let g:nord_bold = 1
"let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1

set background=dark

colorscheme nord

set list

set list lcs=tab:\¦\ 

let g:vim_json_syntax_conceal = 0

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

" Use preset argument to open it
nmap <space>ed :CocCommand explorer --preset .vim<CR>
nmap <space>ef :CocCommand explorer --preset floating<CR>

" List all presets
nmap <space>el :CocList explPresets

let g:indent_guides_exclude_filetypes = ['coc-explorer']

set termguicolors
