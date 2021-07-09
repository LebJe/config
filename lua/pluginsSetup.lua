local U = require("utilities")

local g = vim.g

-- CoC.nvim
require('cocNvimSetup')

-- GitSigns
require('gitsigns').setup {
	current_line_blame_delay = 100,
	current_line_blame = true,
	sign_priority = 100,
	signs = {
    	add          = { hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn' },
    	change       = { hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    	delete       = { hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    	topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    	changedelete = { hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
	}
}

-- TeeSitter
require('nvim-treesitter.configs').setup {
	ensure_installed = {
		"dockerfile",
		"python",
		"graphql",
		"html",
		"bash",
		"c",
		"javascript",
		"json",
		"css",
		"cpp",
		"c",
		"swift",
		"toml",
		"yaml",
		"go",
		"rust",
		"typescript",
		"lua"
	},
	highlight = {
		enable = true,
	},
}

-- nvim-web-icons
require('nvim-web-devicons').setup {
	default = true;
}

-- nvim-bufferline.lua

require('bufferline').setup {
    options = {
		buffer_close_icon = "",
		modified_icon = "",
    	close_icon = "",
    	numbers = "ordinal",
		number_style = "none",
		show_tab_indicators = true,
		enforce_regular_tabs = false,
		offsets = {{ filetype = "coc-explorer", text = "CoC File Explorer", text_align = "center" }}
    }
}

-- diffview.nvim
require('diffview').setup {
	diff_binaries = false,
	file_panel = {
		width = 35,
    	use_icons = true
	},
}

-- neogit
require("neogit").setup {
	integrations = {
    diffview = true
	}
}

require('lualine').setup {
	options = {
    	icons_enabled = true,
    	theme = 'codedark',
		section_separators = {'', ''},
		component_separators = {'', ''},
		
	},
	sections = {
		lualine_a = {
			{
				'mode',
				icon = nil,
			}
		},
		lualine_b = {
			'branch',
			{
				'diff',
				symbols = { added = ' ', modified = '柳', removed = ' ' },
				color_added = '#98be65',
				color_modified = '#FF8800',
				color_removed = '#ec5f67',
			}
		},
		lualine_c = {
			{
				'diagnostics',
				sources = { 'coc' },
				sections = { 'error', 'warn', 'info', 'hint' },
				color_error = '#ec5f67',
				symbols = {error = ' ', warn = ' ', info = ' '},
			},
			'filename',
			'g:coc_status'
		},
		lualine_y = {
			'hostname',
			'progress'
		},
		lualine_x = {
			'filetype',
			'encoding',
			'fileformat',
		}
	}
}

-- Vista
g['vista#renderer#enable_icon'] = true
g.vista_default_executive = 'coc'
g.vista_sidebar_width = 50
g.vista_executive_for = { vimwiki = 'markdown', markdown = 'toc' }

-- Vimspector
g.vimspector_enable_mappings = 'HUMAN'
g.vimspector_install_gadgets = { 'vscode-python', 'vscode-cpptools', 'CodeLLDB' }

U.map('n', '<Leader>di', '<Plug>VimspectorBalloonEval', {})
U.map('x', '<Leader>di', '<Plug>VimspectorBalloonEval', {})

-- csv.vim
g.csv_arrange_align = 'l*'

