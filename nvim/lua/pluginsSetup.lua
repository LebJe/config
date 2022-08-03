local U = require("utilities")

local g = vim.g
local M = {}

-- nvim-autopairs
function M.nvimAutoPairsSetup()
	require("nvim-autopairs").setup({
		map_cr = true,
	})
end

function M.nvimDapVirtualTextSetup()
	require("nvim-dap-virtual-text").setup({
		enabled = true,
		enabled_commands = true,
		highlight_changed_variables = true,
		highlight_new_as_changed = false,
		show_stop_reason = true,
		commented = false,
	})
end

function M.nvimDapUISetup()
	local dapui = require("dapui")
	local dap = require("dap")

	dapui.setup({
		sidebar = {
			elements = {
				{ id = "scopes", size = 0.25 },
				{ id = "breakpoints", size = 0.25 },
				{ id = "stacks", size = 0.25 },
				--{ id = "watches", size = 0.50 },
			},
			size = 70,
			position = "left",
		},
	})

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
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
			"swift",
			"toml",
			"typescript",
			"query",
			"yaml",
		},
		highlight = { enable = true },
	})

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

	--vim.cmd([[
	--	hi clear TSVariable
	--	hi link TSVariable Identifier
	--]])
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
			diagnostics_indicator = function(_, _, diagnostics_dict, _)
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

	U.map("n", "<leader>c", ":BufferLinePickClose<CR>", { noremap = true })
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
	require("nvim-tree").setup({
		diagnostics = {
			enable = true,
		},
		open_on_setup = true,
		update_cwd = true,
		renderer = {
			highlight_git = true,
			highlight_opened_files = "2",
			indent_markers = { enable = false },
			special_files = { "README.md", "Package.swift", "Cargo.toml", "package.json", "Makefile", "MAKEFILE" },
			icons = {
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
				},
			},
		},
		view = {
			--width = 30,
			side = "left",
			adaptive_size = true,
		},
		filters = {
			dotfiles = false,
			custom = {
				".git",
				"node_modules",
				".cache",
				".build",
				".swiftpm",
			},
		},
		git = {
			ignore = true,
		},
	})
	-- Open file tree with <C-n>.
	U.map("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true })

	-- Close tab/nvim when NvimTree is the last window open.
	vim.cmd(
		[[ autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif ]]
	)
end

function M.sidebarNvimConfig()
	local sidebarNVimDiagnostics = require("sidebarConfig")
	local clockSection = require("sidebar-nvim.builtin.datetime")
	local breakpointsSection = require("dap-sidebar-nvim.breakpoints")

	clockSection.title = "Current Date-Time"

	require("sidebar-nvim").setup({
		disable_default_keybindings = 0,
		bindings = {
			["q"] = function()
				require("sidebar-nvim").close()
			end,
		},
		open = false,
		side = "right",
		initial_width = 55,
		update_interval = 500,
		sections = { "datetime", breakpointsSection, sidebarNVimDiagnostics.diagnosticsSection, "git" },
		datetime = {
			format = "%A, %b %d %Y, %I:%M:%S",
		},
		section_separator = "-----",
		disable_closing_prompt = true,
	})

	U.map("n", "<C-j>", ":SidebarNvimToggle<CR>", { noremap = true })
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
end

-- Vista
function M.vistaSetup()
	g["vista#renderer#enable_icon"] = true
	g.vista_default_executive = "coc"
	g.vista_sidebar_width = 50
	g.vista_executive_for = { vimwiki = "markdown", markdown = "toc" }
	U.map("n", "<C-i>", ":Vista<CR>", { noremap = true })
end

-- csv.vim
g.csv_arrange_align = "l*"

return M
