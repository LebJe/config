local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	execute("packadd packer.nvim")
end

return require("packer").startup(function(use)
	-- A use-package inspired plugin manager for Neovim. Uses native packages, supports Luarocks dependencies, written in Lua, allows for expressive config
	use("wbthomason/packer.nvim")

	-- Neovim/Vim color scheme inspired by Dark+ and Light+ theme in Visual Studio Code
	use({
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup()
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
		"GustavoKatel/sidebar.nvim",
		config = function()
			require("pluginsSetup").sidebarNvimConfig()
		end,
	})

	-- A cheatsheet plugin for neovim with bundled cheatsheets for the editor, multiple vim plugins, nerd-fonts, regex, etc. with a Telescope fuzzy finder interface !
	use({ "sudormrfbin/cheatsheet.nvim" })

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

	-- neovim statusline plugin written in lua
	use({
		"glepnir/galaxyline.nvim",
		branch = "main",
		config = function()
			require("galaxySetup").configureStatusline()
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

	-- 🌵 Viewer & Finder for LSP symbols and tag
	use({
		"liuchengxu/vista.vim",
		cnd = "Vista",
		config = function()
			require("pluginsSetup").vistaSetup()
		end,
	})

	use({ "jbyuki/one-small-step-for-vimkind" })

	-- vimspector - A multi-language debugging system for Vim.
	-- use {
	--    "puremourning/vimspector",
	--    cmd = {
	--        "VimspectorBalloonEval", "VimspectorInstall", "VimspectorReset",
	--        "VimspectorUpdate", "VimspectorAbortInstall", "VimspectorEval"
	--    },
	--    keys = { "<F5>", "<F9>", "<F10>" }
	-- }

	use({
		-- A UI for nvim-dap
		"rcarriga/nvim-dap-ui",
		requires = {
			-- Debug Adapter Protocol client implementation for Neovim
			{
				"mfussenegger/nvim-dap",
				config = function()
					require("pluginsSetup").nvimDapSetup()
				end,
			}, -- Adds virtual text support to nvim-dap
			"theHamsta/nvim-dap-virtual-text",
			{ "~/DAPInstall.nvim" },
		},
		config = function()
			require("pluginsSetup").nvimDapUISetup()
		end,
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
	use({ "chrisbra/csv.vim", ft = "csv" })

	-- A Vim plugin that always highlights the enclosing html/xml tags.
	use({ "Valloric/MatchTagAlways" })

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

	-- A strict and fast JSON parser/decoder/encoder written in pure Lua.
	use_rocks({ "lunajson" })

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
