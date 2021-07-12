local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
	execute 'packadd packer.nvim'
end

return require('packer').startup(function(use)
	-- A use-package inspired plugin manager for Neovim. Uses native packages, supports Luarocks dependencies, written in Lua, allows for expressive config
	use 'wbthomason/packer.nvim'

	-- magit for neovim
	use {
		'TimUntersberger/neogit',
		requires = {
			'nvim-lua/plenary.nvim',
			'sindrets/diffview.nvim'
		}
	}

	-- Git signs written in pure lua
	use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

	-- No description
	use { 'norcalli/nvim_utils' }

	-- neovim statusline plugin written in lua
	use { 'glepnir/galaxyline.nvim', branch = 'main' }

	-- Indent guides for Neovim
	use { 'lukas-reineke/indent-blankline.nvim' }

	-- A file explorer tree for neovim written in lua
	use 'kyazdani42/nvim-tree.lua'

	-- A snazzy bufferline for Neovim
	use { 'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons' }

	-- " 📡 Blazing fast minimap for vim, powered by code-minimap written in Rust.
	--use 'wfxr/minimap.vim'

	-- Nvim Treesitter configurations and abstraction layer
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	-- 🌵 Viewer & Finder for LSP symbols and tag
	use 'liuchengxu/vista.vim'

	-- Intellisense engine for Vim8 & Neovim, full language server protocol support as VSCode.
	use { 'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile' }

	-- Auto close parentheses and repeat by dot dot dot...
	use 'cohama/lexima.vim'

	-- A Filetype plugin for csv files.
	use 'chrisbra/csv.vim'

	-- An arctic, north-bluish clean and elegant Vim theme.
	use 'arcticicestudio/nord-vim'

	-- A Vim plugin that always highlights the enclosing html/xml tags.
	use 'Valloric/MatchTagAlways'

	-- A better JSON for Vim: distinct highlighting of keywords vs values, JSON-specific (non-JS) warnings, quote concealing. Pathogen-friendly.
	use 'elzr/vim-json'

	-- Vim runtime files for Swift.
	use 'keith/swift.vim'

	-- vimspector - A multi-language debugging system for Vim.
	use 'puremourning/vimspector'

	-- Vim colorscheme on each tabs
	use 'ujihisa/tabpagecolorscheme'

	-- Dark color scheme for Vim and vim-airline, inspired by Dark+ in Visual Studio Code
	use 'tomasiser/vim-code-dark'

	-- Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP, unite, Denite, lightline, vim-startify and many more.
	-- This should always be last.
	--use 'ryanoasis/vim-devicons'
end)
