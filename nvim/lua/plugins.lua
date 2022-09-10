local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	execute("packadd packer.nvim")
end

return require("packer").startup(function(use, use_rocks)
	-- A use-package inspired plugin manager for Neovim. Uses native packages, supports Luarocks dependencies, written in Lua, allows for expressive config
	use("wbthomason/packer.nvim")

	-- Rocks

	-- A strict and fast JSON parser/decoder/encoder written in pure Lua.
	use_rocks({ "rapidjson" })

	-- Human-readable representation of Lua tables
	use_rocks({ "inspect" })

	-- TOML parser and serializer for Lua. Powered by toml++.
	use_rocks({ "toml" })

	-- Plugins

	-- Find the enemy and replace them with dark power.
	use({ "windwp/nvim-spectre" })

	-- One dark and light colorscheme for neovim >= 0.5.0 written in lua based on Atom's One Dark and Light theme. Additionally, it comes with 5 color variant styles
	use({
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({
				style = "darker",
				term_colors = true,
				ending_tildes = true,
			})
			vim.cmd([[ colorscheme onedark ]])
		end,
	})

	-- lua `fork` of vim-web-devicons for neovim
	use({
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("pluginsSetup").nvimWebIconsSetup()
		end,
	})

	use({
		"sidebar-nvim/sidebar.nvim",
		config = function()
			require("pluginsSetup").sidebarNvimConfig()
		end,
	})

	use({ "sidebar-nvim/sections-dap" })

	-- A cheatsheet plugin for neovim with bundled cheatsheets for the editor, multiple vim plugins, nerd-fonts, regex, etc. with a Telescope fuzzy finder interface !
	use({ "sudormrfbin/cheatsheet.nvim" })

	-- UI

	-- UI Component Library for Neovim.
	use({ "MunifTanjim/nui.nvim" })

	use({ "stevearc/dressing.nvim" })

	-- UI - Search

	-- Start your search from a more comfortable place, say the upper right corner?
	use({
		"VonHeikemen/searchbox.nvim",
		config = function()
			vim.api.nvim_set_keymap("n", "<leader>s", ":SearchBoxIncSearch<CR>", { noremap = false })
		end,
	})

	use({
		"kevinhwang91/nvim-hlslens",
		config = function()
			vim.api.nvim_set_keymap(
				"n",
				"n",
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				{ noremap = true, silent = true }
			)
		end,
	})

	-- A more adventurous wildmenu
	use({
		"gelguy/wilder.nvim",
		config = function()
			vim.fn["wilder#setup"]({ modes = { ":" } })

			-- vim.fn["wilder#set_option"](
			-- 	"renderer",
			-- 	vim.fn["wilder#popupmenu_renderer"](
			-- 		vim.fn["wilder#popupmenu_border_theme"]({
			-- 			highlights = { border = "Normal" },
			-- 			border = "rounded"
			-- 		})
			-- 	)
			-- )
			--

			vim.cmd([[
				call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
      			\ 'highlights': {
      			\   'border': 'Normal',
      			\ },
      			\ 'border': 'rounded',
      			\ })))
			]])
		end,
	})

	-- Git

	-- magit for neovim
	use({
		"TimUntersberger/neogit",
		requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
		cmd = "Neogit",
		config = function()
			require("pluginsSetup").neoGitSetup()
		end,
	})

	-- Git signs written in pure lua
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("pluginsSetup").gitSignsSetup()
		end,
	})

	-- Statusline and Bufferline

	-- A minimal, stylish and customizable statusline for Neovim written in Lua
	use({
		"feline-nvim/feline.nvim",
		config = function()
			require("felineSetup").configureStatusline()
		end,
	})

	-- A snazzy bufferline for Neovim
	use({
		"akinsho/bufferline.nvim",
		config = function()
			require("pluginsSetup").nvimBufferlineSetup()
		end,
	})

	-- Indent guides for Neovim
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("pluginsSetup").indentBlankLineSetup()
		end,
	})

	-- EditorConfig plugin for Vim
	use({ "editorconfig/editorconfig-vim" })

	-- A file explorer tree for neovim written in lua
	use({
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("pluginsSetup").nvimTreeSetup()
		end,
	})

	-- " 📡 Blazing fast minimap for vim, powered by code-minimap written in Rust.
	-- use { "wfxr/minimap.vim" }

	-- TreeSitter

	-- Nvim Treesitter configurations and abstraction layer
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("pluginsSetup").treeSitterSetup()
		end,
	})

	-- Treesitter playground integrated into Neovim
	use({ "nvim-treesitter/playground" })

	use({
		"p00f/nvim-ts-rainbow",
		config = function()
			require("nvim-treesitter.configs").setup({
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = nil,
				},
			})
		end,
	})

	-- LSP and DAP Clients

	-- Intellisense engine for Vim8 & Neovim, full language server protocol support as VSCode.
	use({
		"neoclide/coc.nvim",
		branch = "master",
		run = "yarn install --frozen-lockfile",
		config = function()
			require("cocNvimSetup")
		end,
	})

	use({ "jbyuki/one-small-step-for-vimkind" })

	-- Debugger
	use({
		-- A UI for nvim-dap
		"rcarriga/nvim-dap-ui",
		requires = {
			-- Debug Adapter Protocol client implementation for Neovim
			{
				"mfussenegger/nvim-dap",
				config = function()
					require("nvimDapSetup").nvimDapSetup()
				end,
			},

			-- Adds virtual text support to nvim-dap
			{
				"theHamsta/nvim-dap-virtual-text",
				config = function()
					require("pluginsSetup").nvimDapVirtualTextSetup()
				end,
			},

			-- 🐞 Debug Adapter Protocol manager for Neovi
			-- {
			-- 	"Pocco81/dap-buddy.nvim",
			-- 	branch = "dev",
			-- },
		},
		config = function()
			require("pluginsSetup").nvimDapUISetup()
		end,
	})

	-- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
	use({
		"williamboman/mason.nvim",
		config = function()
			require("pluginsSetup").masonNvimSetup()
		end,
		requires = {
			-- Install and upgrade third party tools automatically
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				config = function()
					require("pluginsSetup").masonToolInstallerSetup()
				end,
			},
		},
	})

	-- autopairs for neovim written by lua
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("pluginsSetup").nvimAutoPairsSetup()
		end,
	})

	-- Syntax Highlighting

	-- Vim runtime files for Swift.
	use({ "keith/swift.vim" })

	-- A Filetype plugin for csv files.
	use({
		"chrisbra/csv.vim",
		ft = "csv",
		config = function()
			require("pluginsSetup").csvSetup()
		end,
	})

	-- Utilities

	-- Find, Filter, Preview, Pick. All lua, all the time.
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			-- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice.
			{ "nvim-lua/plenary.nvim" },
		},
	})

	-- [WIP] An implementation of the Popup API from vim in Neovim. Hope to upstream when complete
	use({ "nvim-lua/popup.nvim" })

	-- A fancy, configurable, notification manager for NeoVim
	use({
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				stages = "fade_in_slide_out",
			})

			vim.notify = require("notify")
		end,
	})
end)
