local U = require("utilities")
local Settings = {}

-- Determine the path to the LLDB library based on:
-- - Envrironment variables (`LIBLLDB`)
-- - Operationg system
-- 	- If on OSX, the LLDB in Xcode-beta.app will be used if it exists.
local function libLLDBSetup()
	local succeded, libLLDB = pcall(os.getenv, "LIBLLDB")
	if succeded and libLLDB ~= nil then
		return libLLDB
	end

	local os = jit.os

	if os == "OSX" then
		local libLLDBPath = "/Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Versions/A/LLDB"
		local libLLDBBetaPath = "/Applications/Xcode-beta.app/Contents/SharedFrameworks/LLDB.framework/Versions/A/LLDB"

		if vim.fn.filereadable(libLLDBPath) then
			return libLLDBPath
		elseif vim.fn.filereadable(libLLDBBetaPath) then
			return libLLDBBetaPath
		end
	elseif os == "Linux" and vim.fn.filereadable("usr/lib/liblldb.so") then
		return "/usr/lib/liblldb.so"
	end
end

-- The LLDB library to use for debugging with nvim-dap.
Settings.libLLDB = libLLDBSetup()

function Settings.setOptions()
	local o = vim.o

	vim.filetype.add({
		extension = {
			scm = "query",
			geojson = "json",
		},
	})

	o.termguicolors = true
	o.splitbelow = true
	o.splitright = true
	o.hidden = true
	o.tabstop = 4
	o.shiftwidth = 4
	o.backspace = "indent,eol,start"
	vim.wo.number = true
	o.updatetime = 200
	o.cursorline = true
	o.encoding = "utf8"
	o.cmdheight = 2

	vim.cmd([[
	set shortmess+=nc
	set guicursor=i:ver25-iCursor
	set guicursor+=a:blinkon100

	if has("patch-8.1.1564")	
		set signcolumn=yes
	else
		set signcolumn=yes
	endif
	]])
end

function Settings.setKeymaps()
	-- Open a terminal in the current buffer.
	vim.cmd([[cabbrev t terminal]])

	vim.cmd([[cabbrev re resize]])
	vim.cmd([[cabbrev vre vertical resize]])

	-- Shortcut for opening new tab.
	vim.cmd([[cabbrev tt tabe]])

	-- Close the current terminal with <Esc>.
	U.map("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

	-- Split navigation.
	U.map("n", "<C-J>", "<C-W><C-J>", { noremap = true })
	U.map("n", "<C-K>", "<C-W><C-K>", { noremap = true })
	U.map("n", "<C-L>", "<C-W><C-L>", { noremap = true })
	U.map("n", "<C-H>", "<C-W><C-H>", { noremap = true })
end

return Settings
