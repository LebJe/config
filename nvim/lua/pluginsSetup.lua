local U = require("utilities")

local g = vim.g
local M = {}

function CompletionConfirm()
	local npairs = require("nvim-autopairs")
	
	if vim.fn.pumvisible() ~= 0 then
        return npairs.esc("<cr>")
    else
        return npairs.autopairs_cr()
    end
end

-- nvim-autopairs
function M.nvimAutoPairsSetup()
    require("nvim-autopairs").setup()

    U.map("i", "<CR>", "v:lua.CompletionConfirm()", { expr = true, noremap = true })
end

function M.nvimDapSetup()
	U.map("n", "<leader>dd", ":lua require('dap').disconnect(); require('dap').close(); require('dapui').close()<CR>", { silent = true, noremap = true })
end

function M.nvimDapUISetup()
	require("dapui").setup()
end

-- GitSigns
function M.gitSignsSetup()
    require("gitsigns").setup {
        current_line_blame_opts = {
			delay = 100
		},
        current_line_blame = true,
        sign_priority = 100,
        signs = {
            add = {
                hl = "GitSignsAdd",
                text = "│",
                numhl = "GitSignsAddNr",
                linehl = "GitSignsAddLn"
            },
            change = {
                hl = "GitSignsChange",
                text = "│",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn"
            },
            delete = {
                hl = "GitSignsDelete",
                text = "_",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn"
            },
            topdelete = {
                hl = "GitSignsDelete",
                text = "‾",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn"
            },
            changedelete = {
                hl = "GitSignsChange",
                text = "~",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn"
            }
        }
    }
end

-- TreeSitter
function M.treeSitterSetup()
    require("nvim-treesitter.configs").setup {
        ensure_installed = {
            "bash", "c", "cpp", "css", "dockerfile", "go", "graphql", "html",
            "javascript", "json", "lua", "python", "rust", "toml", "typescript",
            "query", "yaml"
        },
        highlight = { enable = true }
    }

    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.swift = {
        install_info = {
            url = "~/Programs/Parsers/old-ts-swift",
            files = { "src/parser.c" }
        },
        filetype = "swift"
    }

    require("nvim-treesitter.configs").setup {
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
                show_help = "?"
            }
        },
        query_linter = {
            enable = true,
            use_virtual_text = true,
            lint_events = { "BufWrite", "CursorHold" }
        }
    }
end

-- nvim-bufferline.lua
function M.nvimBufferlineSetup()
    require("bufferline").setup {
        options = {
            buffer_close_icon = "",
            modified_icon = "",
            close_icon = "",
            numbers = function(opts)
    					return string.format('%s.', opts.ordinal)
  					end,
            show_tab_indicators = true,
            enforce_regular_tabs = false,
            offsets = {
                {
                    filetype = "coc-explorer",
                    text = "CoC File Explorer",
                    text_align = "center"
                }
            }
        },
        highlights = {
            fill = {
                guifg = { attribute = "fg", highlight = "Normal" },
                guibg = { attribute = "bg", highlight = "StatusLineNC" }
            },
            background = {
                guifg = { attribute = "fg", highlight = "Normal" },
                guibg = { attribute = "bg", highlight = "StatusLine" }
            },
            buffer_visible = {
                gui = "",
                guifg = { attribute = "fg", highlight = "Normal" },
                guibg = { attribute = "bg", highlight = "Normal" }
            },
            buffer_selected = {
                gui = "",
                guifg = { attribute = "fg", highlight = "Normal" },
                guibg = { attribute = "bg", highlight = "Normal" }
            },
            separator = {
                guifg = { attribute = "bg", highlight = "Normal" },
                guibg = { attribute = "bg", highlight = "StatusLine" }
            },
            separator_selected = {
                guifg = { attribute = "fg", highlight = "Special" },
                guibg = { attribute = "bg", highlight = "Normal" }
            },
            separator_visible = {
                guifg = { attribute = "fg", highlight = "Normal" },
                guibg = { attribute = "bg", highlight = "StatusLineNC" }
            },
            close_button = {
                guifg = { attribute = "fg", highlight = "Normal" },
                guibg = { attribute = "bg", highlight = "StatusLine" }
            },
            close_button_selected = {
                guifg = { attribute = "fg", highlight = "normal" },
                guibg = { attribute = "bg", highlight = "normal" }
            },
            close_button_visible = {
                guifg = { attribute = "fg", highlight = "normal" },
                guibg = { attribute = "bg", highlight = "normal" }
            }
        }
    }
end

-- diffview.nvim
function M.diffviewSetup()
    require("diffview").setup {
        diff_binaries = false,
        file_panel = { width = 35, use_icons = true }
    }
end

-- neogit
function M.neoGitSetup()
	require("neogit").setup { integrations = { diffview = true } }
end

-- require('lualine').setup {
--	options = {
--    	icons_enabled = true,
--    	theme = 'codedark',
--		section_separators = {'', ''},
--		component_separators = {'', ''},
--
--	},
--	sections = {
--		lualine_a = {
--			{
--				'mode',
--				icon = nil,
--			}
--		},
--		lualine_b = {
--			'branch',
--			{
--				'diff',
--				symbols = { added = ' ', modified = '柳', removed = ' ' },
--				color_added = '#98be65',
--				color_modified = '#FF8800',
--				color_removed = '#ec5f67',
--			}
--		},
--		lualine_c = {
--			{
--				'diagnostics',
--				sources = { 'coc' },
--				sections = { 'error', 'warn', 'info', 'hint' },
--				color_error = '#ec5f67',
--				symbols = {error = ' ', warn = ' ', info = ' '},
--			},
--			'filename',
--			'g:coc_status'
--		},
--		lualine_y = {
--			'hostname',
--			'progress'
--		},
--		lualine_x = {
--			'filetype',
--			'encoding',
--			'fileformat',
--		}
--	}
-- }

-- indent_blankline.nvim
function M.indentBlankLineSetup()
	g.indentLine_char = "▏"
	g.indent_blankline_buftype_exclude = { "terminal" }
	
	vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 guibg=NONE gui=NONE blend=nocombine]]
	vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B guibg=NONE gui=NONE blend=nocombine]]
	vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 guibg=NONE gui=NONE blend=nocombine]]
	vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 guibg=NONE gui=NONE blend=nocombine]]
	vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF guibg=NONE gui=NONE blend=nocombine]]
	vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD guibg=NONE gui=NONE blend=nocombine]]
	
	require("indent_blankline").setup {
	    space_char_blankline = " ",
	    char_highlight_list = {
	        "IndentBlanklineIndent1",
	        "IndentBlanklineIndent2",
	        "IndentBlanklineIndent3",
	        "IndentBlanklineIndent4",
	        "IndentBlanklineIndent5",
	        "IndentBlanklineIndent6",
	    },
	}
end


-- nvim-tree.lua
g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
g.nvim_tree_gitignore = 1
g.nvim_tree_auto_open = 1
g.nvim_tree_auto_close = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_lsp_diagnostics = 1

g.nvim_tree_special_files = {
    ["README.md"] = 1,
    ["Package.swift"] = 1,
    ["Cargo.toml"] = 1,
    ["package.json"] = 1,
    ["Makefile"] = 1,
    ["MAKEFILE"] = 1
}

g.nvim_tree_show_icons = {
    ["git"] = 1,
    ["folders"] = 1,
    ["files"] = 1,
    ["folder_arrows"] = 1
}

-- Open file tree with <C-n>.
U.map("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true })

-- Vista
g["vista#renderer#enable_icon"] = true
g.vista_default_executive = "coc"
g.vista_sidebar_width = 50
g.vista_executive_for = { vimwiki = "markdown", markdown = "toc" }

-- Vimspector
g.vimspector_enable_mappings = "HUMAN"
g.vimspector_install_gadgets = { "CodeLLDB" }

U.map("n", "<Leader>di", "<Plug>VimspectorBalloonEval", {})
U.map("x", "<Leader>di", "<Plug>VimspectorBalloonEval", {})

-- csv.vim
g.csv_arrange_align = "l*"

return M
