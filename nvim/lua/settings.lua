local U = require('utilities')

local Settings = {}

local cmd = vim.cmd

function Settings.setOptions()
	local o = vim.o

	o.termguicolors = true
	o.splitbelow = true
	o.splitright = true
	o.hidden = true
	o.tabstop = 4
	o.shiftwidth = 4
	o.backspace = 'indent,eol,start'
	vim.wo.number = true
	o.updatetime = 200
	o.cursorline = true
	o.background = 'dark'
	o.encoding = 'utf8'
	o.cmdheight = 2
	
	cmd[[colorscheme codedark]]
	cmd[[set list lcs=tab:\▏\ ]]
	cmd[[
	set shortmess+=nc

	if has("patch-8.1.1564")	
		set signcolumn=number
	else
		set signcolumn=yes
	endif
	]]
end

function Settings.setKeymaps()
	cmd[[
	fun! SetupTerminal()
		:terminal
	endfun
	]]

	-- Choose a buffer using nvim-bufferline.nvim
	U.map('n', 'gb', ':BufferLinePick<CR>', { noremap = true, silent = true })
	
	-- Open a terminal in the current buffer.
	U.map('', '<c-t>', ':terminal<enter>', {})

	-- Close the current terminal with <Esc>.
	U.map('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

	-- Split navigation.
	U.map('n', '<C-J>', '<C-W><C-J>', { noremap = true })
	U.map('n', '<C-K>', '<C-W><C-K>', { noremap = true })
	U.map('n', '<C-L>', '<C-W><C-L>', { noremap = true })
	U.map('n', '<C-H>', '<C-W><C-H>', { noremap = true })
end

function Settings.setHighlights()
	cmd[[au VimEnter * hi GitSignsAdd guifg=#009900 ctermfg=2]]
	cmd[[au VimEnter * hi GitSignsChange guifg=#bbbb00 ctermfg=3]]
	cmd[[au VimEnter * hi GitSignsDelete guifg=#ff2222 ctermfg=1]]
end

Settings.setOptions()
Settings.setKeymaps()
Settings.setHighlights()

--let g:airline_exclude_filetypes = ['minimap', 'coc-explorer']
--let g:airline_exclude_buftypes = ['minimap', 'coc-explorer']
--
-- minimap.vim config
--let g:minimap_width = 20
--let g:minimap_git_colors = 1
--hi MinimapCurrentLine ctermfg=Green guifg=#50FA7B guibg=#32302f
--let g:minimap_highlight = 'MinimapCurrentLine'
--let g:minimap_block_filetypes = ['coc-explorer']
--let g:minimap_block_buftypes = ['nofile', 'nowrite', 'quickfix', 'terminal', 'prompt', 'coc-explorer']
--let g:minimap_close_filetypes = ['startify', 'netrw', 'vim-plug', 'coc-explorer']
--
--let g:minimap_auto_start = 0
