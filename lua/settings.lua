local U = require('utilities')

local Settings = {}

local cmd = vim.cmd

function Settings.setOptions()
	local o = vim.o
	o.termguicolors = true
	o.tabstop = 4
	o.shiftwidth = 4
	vim.o.backspace = 'indent,eol,start'
	vim.wo.number = true
	o.updatetime = 200
	o.cursorline = true
	o.background = 'dark'
	cmd[[colorscheme codedark]]
	o.encoding = 'utf8'
	cmd[[
	set shortmess+=nc

	if has("patch-8.1.1564")	
		set signcolumn=number
	else
		set signcolumn=yes
	endif
	]]

	o.cmdheight = 2

end

function Settings.setKeymaps()
	U.map('n', 'gb', ':BufferLinePick<CR>', { noremap = true, silent = true })
	U.map('', '<c-t>', ':call OpenTerminal()<enter>', {})
	U.map('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
end

function Settings.setHighlights()
	cmd[[au VimEnter * hi GitSignsAdd guifg=#009900 ctermfg=2]]
	cmd[[au VimEnter * hi GitSignsChange guifg=#bbbb00 ctermfg=3]]
	cmd[[au VimEnter * hi GitSignsDelete guifg=#ff2222 ctermfg=1]]
end

Settings.setOptions()
Settings.setKeymaps()
Settings.setHighlights()
