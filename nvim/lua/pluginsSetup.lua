local U = require("utilities")

local g = vim.g
local M = {}

-- nvim-autopairs
function M.nvimAutoPairsSetup()
	require("nvim-autopairs").setup()

	U.map("i", "<CR>", "v:lua.CompletionConfirm()", { expr = true, noremap = true })
end

-- Get information about debuggable executables from `swift package`.
function M.dapConfigFromSwiftPackage()
	if vim.loop.fs_access(vim.loop.cwd() .. "/Package.swift", "r") then
		local dap = require("dap")
		local fh = io.popen("swift package describe --type json")
		local data = fh:read("*all")

		fh:close()

		local lunajson = require("lunajson")

		local succeded, tbl = pcall(lunajson.decode, data)

		local configArray = {}
		local libLLDB = require("settings").libLLDB

		if succeded and tbl ~= nil then
			for _, value in ipairs(tbl.products) do
				if value.type.executable ~= nil then
					table.insert(configArray, {
						type = "vscode_lldb",
						adapter = "vscode_lldb",
						request = "launch",
						name = value.targets[0] .. "- Debug Executable " .. value.name,
						program = "${workspaceFolder}/.build/debug/value",
						liblldb = libLLDB,
					})
				end
			end
		else
			vim.notify(
				"Error in `swift package describe --json` JSON:\n\n" .. tbl,
				"error",
				{ title = "DAP Configuration" }
			)
		end

		-- Setup configurations.
		dap.configurations.swift = configArray
	end
end

function M.nvimDapSetup()
	local dap_install = require("dap-install")
	local dap = require("dap")
	vim.g.dap_virtual_text = true

	dap.set_log_level("TRACE")

	-- Mappings
	U.map(
		"n",
		"<leader>dd",
		":lua require('dap').disconnect(); require('dap').close(); require('dapui').close()<CR>",
		{ silent = true, noremap = true }
	)
	U.map(
		"n",
		"<F5>",
		":lua require('pluginsSetup').dapConfigFromSwiftPackage(); require('dap').continue()<CR>",
		{ silent = true, noremap = true }
	)
	U.map(
		"n",
		"<F8>",
		":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
		{ silent = true, noremap = true }
	)
	U.map("n", "<F9>", ":lua require('dap').toggle_breakpoint()<CR>", { silent = true, noremap = true })
	U.map("n", "<F10>", ":lua require('dap').step_over()<CR>", { silent = true, noremap = true })
	U.map("n", "<F11>", ":lua require('dap').step_into()<CR>", { silent = true, noremap = true })
	U.map("n", "<F12>", ":lua require('dap').step_out()<CR>", { silent = true, noremap = true })

	-- Debuggers

	dap_install.config("vscode_lldb", {})

	dap.configurations.c = {
		{
			type = "vscode_lldb",
			request = "launch",
			name = "Debug Executable - " .. vim.loop.cwd() .. "/main",
			program = "${workspaceFolder}/main",
			--cargo = {},
			--args = {},
			--terminal = "integrated",
			env = {
				A = "A",
			},
			cwd = "${workspaceFolder}",
		},
		{
			type = "lldb",
			request = "launch",
			name = "Debug Executable - Choose",
			program = function()
				return "${workspaceFolder}/" .. vim.fn.input(vim.loop.cwd() .. "/")
			end,
		},
	}
end

function M.nvimDapUISetup()
	require("dapui").setup()
end

-- GitSigns
function M.gitSignsSetup()
	require("gitsigns").setup({
		current_line_blame_opts = { delay = 100 },
		current_line_blame = true,
		sign_priority = 100,
		signs = {
			add = {
				hl = "GitSignsAdd",
				text = "│",
				numhl = "GitSignsAddNr",
				linehl = "GitSignsAddLn",
			},
			change = {
				hl = "GitSignsChange",
				text = "│",
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
			delete = {
				hl = "GitSignsDelete",
				text = "_",
				numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn",
			},
			topdelete = {
				hl = "GitSignsDelete",
				text = "‾",
				numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn",
			},
			changedelete = {
				hl = "GitSignsChange",
				text = "~",
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
		},
	})
end

-- TreeSitter
function M.treeSitterSetup()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"c",
			"cpp",
			"css",
			"dockerfile",
			"go",
			"graphql",
			"html",
			"javascript",
			"json",
			"lua",
			"python",
			"rust",
			"toml",
			"typescript",
			"query",
			"yaml",
		},
		highlight = { enable = true },
	})

	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	parser_config.swift = {
		install_info = {
			url = "~/Programs/Parsers/tree-sitter-swift",
			files = { "src/parser.c" },
		},
		filetype = "swift",
	}

	require("nvim-treesitter.configs").setup({
		playground = {
			enable = true,
			updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
			persist_queries = false, -- Whether the query persists across vim sessions
			keybindings = {
				toggle_query_editor = "o",
				toggle_hl_groups = "i",
				toggle_injected_languages = "t",
				toggle_anonymous_nodes = "a",
				toggle_language_display = "I",
				focus_language = "f",
				unfocus_language = "F",
				update = "R",
				goto_node = "<cr>",
				show_help = "?",
			},
		},
		query_linter = {
			enable = true,
			use_virtual_text = true,
			lint_events = { "BufWrite", "CursorHold" },
		},
	})

	vim.cmd([[
	hi clear TSVariable
		hi link TSVariable Identifier
	]])
end

-- nvim-bufferline.lua
function M.nvimBufferlineSetup()
	-- Choose buffer
	U.map("n", "gb", ":BufferLinePick<CR>", { noremap = true, silent = true })

	require("bufferline").setup({
		options = {
			buffer_close_icon = "",
			modified_icon = "",
			close_icon = "",
			numbers = function(opts)
				return string.format("%s.", opts.ordinal)
			end,
			diagnostics = "coc",
			diagnostics_update_in_insert = true,
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local s = ""

				for e, n in pairs(diagnostics_dict) do
					local sym = e == "error" and " " or (e == "warning" and " " or "")
					s = s .. sym .. " " .. n .. " "
				end

				return s
			end,
			show_buffer_icons = true,
			show_tab_indicators = true,
			enforce_regular_tabs = false,
			offsets = {
				{ filetype = "NvimTree", text = "File Explorer", text_align = "center" },
				{ filetype = "SidebarNvim", text = "Sidebar", text_align = "center" },
				{ filetype = "vista", text = "Outline", text_align = "center" },
			},
		},
	})
end

-- diffview.nvim
function M.diffviewSetup()
	require("diffview").setup({
		diff_binaries = false,
		file_panel = { width = 35, use_icons = true },
	})
end

-- neogit
function M.neoGitSetup()
	require("neogit").setup({ integrations = { diffview = true } })
end

-- indent_blankline.nvim
function M.indentBlankLineSetup()
	g.indentLine_char = "▏"
	g.indent_blankline_buftype_exclude = { "terminal" }

	require("indent_blankline").setup({ space_char_blankline = " " })
end

-- nvim-tree.lua
function M.nvimTreeSetup()
	g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
	g.nvim_tree_gitignore = 1
	--g.nvim_tree_auto_open = 1
	--g.nvim_tree_auto_close = 1
	g.nvim_tree_indent_markers = 1
	g.nvim_tree_git_hl = 1
	g.nvim_tree_highlight_opened_files = 1
	--g.nvim_tree_lsp_diagnostics = 1

	g.nvim_tree_special_files = {
		["README.md"] = true,
		["Package.swift"] = true,
		["Cargo.toml"] = true,
		["package.json"] = true,
		["Makefile"] = true,
		["MAKEFILE"] = true,
	}

	g.nvim_tree_show_icons = {
		["git"] = 1,
		["folders"] = 1,
		["files"] = 1,
		["folder_arrows"] = 1,
	}

	require("nvim-tree").setup({
		lsp_diagnostics = true,
		open_on_setup = true,
		auto_close = true,
		update_cwd = true,
		view = {
			--width = 30,
			side = "left",
			auto_resize = true,
		},
	})
	-- Open file tree with <C-n>.
	U.map("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true })
end

function M.sidebarNvimConfig()
	--require("sidebar-nvim").setup({
	--    disable_default_keybindings = 0,
	--    bindings = nil,
	--    open = false,
	--    side = "right",
	--    initial_width = 35,
	--    update_interval = 1000,
	--    sections = { "datetime", "git-status", "containers" },
	--	docker = {
	--        attach_shell = "/bin/sh",
	--        show_all = true, -- whether to run `docker ps` or `docker ps -a`
	--    },
	--    section_separator = "-----"
	--})
end

function M.nvimWebIconsSetup()
	require("nvim-web-devicons").setup({
		default = true,
		override = {
			c = { icon = "", color = "#599eff", name = "c" },
			css = { icon = "", color = "#563d7c", name = "css" },
			deb = { icon = "", color = "#C91D3C", name = "deb" },
			Dockerfile = { icon = "", color = "#2496ED", name = "Dockerfile" },
		},
	})

	--require("nvim-web-devicons").set_up_highlights()
end

-- Vista
function M.vistaSetup()
	g["vista#renderer#enable_icon"] = true
	g.vista_default_executive = "coc"
	g.vista_sidebar_width = 50
	g.vista_executive_for = { vimwiki = "markdown", markdown = "toc" }
end

-- Vimspector
g.vimspector_enable_mappings = "HUMAN"
g.vimspector_install_gadgets = { "CodeLLDB" }

U.map("n", "<Leader>di", "<Plug>VimspectorBalloonEval", {})
U.map("x", "<Leader>di", "<Plug>VimspectorBalloonEval", {})

-- csv.vim
g.csv_arrange_align = "l*"

return M
