local gl = require("galaxyline")
local colors = require("galaxyline.theme").default
local condition = require("galaxyline.condition")
local gls = gl.section

gl.short_line_list = { "NvimTree", "vista", "packer" }

colors.bg1 = "#393b39"
colors.bg2 = "#2d2e2d"
colors.bg3 = "#232423"
colors.b4 = "#202120"

local M = {}

-- Returns `true` if coc.nvim is showing warnings, hinnts, errors, or information; otherwise `false`.
function ShouldShowLSPSeparator()
    if vim.fn.exists("*coc#rpc#start_server") == 0 then return false end

    local has_info, info = pcall(vim.api.nvim_buf_get_var, 0, "coc_diagnostic_info")

    if not has_info then return false end

    if info["error"] > 0 then return true end

    if info["warning"] > 0 then return true end

    if info["hint"] > 0 then return true end

    if info["information"] > 0 then return true end
    return true
end

function M.configureStatusline()
	-- Change the color of this section according to the (Neo)Vim mode.
	gls.left[1] = {
	    ViMode = {
	        provider = function()
	            local alias = {
	                ["n"] = "NORMAL",
	                ["no"] = "O-PENDING",
	                ["nov"] = "O-PENDING",
	                ["noV"] = "O-PENDING",
	                ["no"] = "O-PENDING",
	                ["niI"] = "NORMAL",
	                ["niR"] = "NORMAL",
	                ["niV"] = "NORMAL",
	                ["v"] = "VISUAL",
	                ["V"] = "V-LINE",
	                [""] = "V-BLOCK",
	                ["s"] = "SELECT",
	                ["S"] = "S-LINE",
	                [""] = "S-BLOCK",
	                ["i"] = "INSERT",
	                ["ic"] = "INSERT",
	                ["ix"] = "INSERT",
	                ["R"] = "REPLACE",
	                ["Rc"] = "REPLACE",
	                ["Rv"] = "V-REPLACE",
	                ["Rx"] = "REPLACE",
	                ["c"] = "COMMAND",
	                ["cv"] = "EX",
	                ["ce"] = "EX",
	                ["r"] = "REPLACE",
	                ["rm"] = "MORE",
	                ["r?"] = "CONFIRM",
	                ["!"] = "SHELL",
	                ["t"] = "TERMINAL"
	            }
	
	            local modeColor = {
	                ["n"] = colors.green,
	                ["no"] = colors.magenta,
	                ["nov"] = colors.magenta,
	                ["noV"] = colors.magenta,
	                ["no"] = colors.magenta,
	                ["niI"] = colors.green,
	                ["niR"] = colors.green,
	                ["niV"] = colors.green,
	                ["v"] = colors.magenta,
	                ["V"] = colors.blue,
	                [""] = colors.purple,
	                ["s"] = colors.orange,
	                ["S"] = colors.orange,
	                [""] = colors.orange,
	                ["i"] = colors.blue,
	                ["ic"] = colors.yellow,
	                ["ix"] = colors.blue,
	                ["R"] = colors.yellow,
	                ["Rc"] = colors.cyan,
	                ["Rv"] = colors.purple,
	                ["Rx"] = colors.cyan,
	                ["c"] = colors.red,
	                ["cv"] = colors.red,
	                ["ce"] = colors.red,
	                ["r"] = colors.cyan,
	                ["rm"] = colors.cyan,
	                ["r?"] = colors.cyan,
	                ["!"] = colors.green,
	                ["t"] = colors.green
	            }
	
	            local vim_mode = vim.fn.mode()
	            if (alias[vim_mode] == nil or modeColor[vim_mode] == nil) then
	                vim.api.nvim_command("hi GalaxyViMode guifg=" .. colors.red)
	                return "  UNKNOWN    "
	            else
	                vim.api.nvim_command("hi GalaxyViMode guifg=" .. modeColor[vim_mode])
	                return "  " .. alias[vim_mode] .. "    "
	            end
	        end,
	        highlight = { colors.red, colors.bg1, "bold" }
	    }
	}
	
	gls.left[3] = {
	    FileIcon = {
	        provider = "FileIcon",
	        condition = condition.buffer_not_empty,
	        highlight = {
	            require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg1
	        }
	    }
	}
	
	gls.left[4] = {
	    FileName = {
	        provider = "FileName",
	        condition = condition.buffer_not_empty,
	        highlight = { colors.magenta, colors.bg1, "bold" }
	    }
	}
	
	gls.left[5] = {
	    Sep1 = {
	        provider = function() return " " end,
	        highlight = { colors.bg1, colors.bg2 }
	    }
	}
	
	-- Git
	
	gls.left[6] = {
	    GitIcon = {
	        provider = function() return "  " end,
	        condition = condition.check_git_workspace,
	        highlight = { colors.violet, colors.bg2, "bold" }
	    }
	}
	
	-- Git - Branch
	
	gls.left[7] = {
	    GitBranch = {
	        provider = "GitBranch",
	        condition = condition.check_git_workspace,
	        separator = " ",
	        separator_highlight = { colors.bg2, colors.bg2 },
	        highlight = { colors.violet, colors.bg2, "bold" }
	    }
	}
	
	-- Git - Diff Information
	
	gls.left[8] = {
	    DiffAdd = {
	        provider = "DiffAdd",
	        condition = condition.hide_in_width,
	        icon = "  ",
	        highlight = { colors.green, colors.bg2 }
	    }
	}
	gls.left[9] = {
	    DiffModified = {
	        provider = "DiffModified",
	        condition = condition.hide_in_width,
	        icon = " 柳",
	        highlight = { colors.orange, colors.bg2 }
	    }
	}
	
	gls.left[10] = {
	    DiffRemove = {
	        provider = "DiffRemove",
	        condition = condition.hide_in_width,
	        icon = "  ",
	        highlight = { colors.red, colors.bg2 }
	    }
	}
	
	gls.left[11] = {
	    Sep2 = {
	        provider = function() return "" end,
	        -- condition = ShouldShowLSPSeparator,
	        highlight = { colors.bg2, colors.bg3 }
	    }
	}
	
	-- Diagnostics
	
	gls.left[12] = {
	    DiagnosticError = {
	        provider = "DiagnosticError",
	        icon = "  ",
	        highlight = { colors.red, colors.bg3 },
	        separator = " ",
	        separator_highlight = { colors.fg, colors.bg3, "bold" }
	    }
	}
	gls.left[13] = {
	    DiagnosticWarn = {
	        provider = "DiagnosticWarn",
	        icon = "  ",
	        highlight = { colors.yellow, colors.bg3 },
	        separator = " ",
	        separator_highlight = { colors.fg, colors.bg3, "bold" }
	    }
	}
	
	gls.left[14] = {
	    DiagnosticHint = {
	        provider = "DiagnosticHint",
	        icon = "  ",
	        highlight = { colors.cyan, colors.bg },
	        separator = " ",
	        separator_highlight = { colors.fg, colors.bg3, "bold" }
	    }
	}
	
	gls.left[15] = {
	    DiagnosticInfo = {
	        provider = "DiagnosticInfo",
	        icon = "  ",
	        highlight = { colors.blue, colors.bg3 },
	        separator = " ",
	        separator_highlight = { colors.fg, colors.bg3, "bold" }
	    }
	}
	
	gls.left[16] = {
	    Sep3 = {
	        provider = function() return " " end,
	        condition = ShouldShowLSPSeparator,
	        highlight = { colors.bg3, colors.bg3 }
	    }
	}
	
	gls.mid[1] = {
	    ShowLspClient = {
	        provider = function() return vim.g.coc_status end,
	        icon = "  LSP:",
	        highlight = { colors.white, colors.bg, "bold" }
	    }
	}
	
	-- File Location
	
	gls.right[1] = {
	    LineInfo = {
	        provider = "LineColumn",
	        separator = " ",
	        separator_highlight = { colors.bg2, colors.bg2 },
	        highlight = { colors.fg, colors.bg2 }
	    }
	}
	
	gls.right[2] = {
	    PerCent = {
	        provider = "LinePercent",
	        separator = " ",
	        separator_highlight = { colors.bg2, colors.bg2 },
	        highlight = { colors.fg, colors.bg2, "bold" }
	    }
	}
	
	-- File Information
	
	gls.right[3] = {
	    FileSize = {
	        provider = "FileSize",
	        condition = condition.buffer_not_empty,
	        highlight = { colors.fg, colors.bg2 },
	        separator = " ",
	        separator_highlight = { colors.bg2, colors.bg2 }
	    }
	}
	
	gls.right[4] = {
	    Sep4 = {
	        provider = function() return " " end,
	        highlight = { colors.bg1, colors.bg2 }
	    }
	}
	
	gls.right[5] = {
	    FileEncode = {
	        provider = "FileEncode",
	        condition = condition.hide_in_width,
	        separator = " ",
	        separator_highlight = { colors.bg1, colors.bg1 },
	        highlight = { colors.green, colors.bg1, "bold" }
	    }
	}
	
	gls.right[6] = {
	    FileFormat = {
	        provider = "FileFormat",
	        condition = condition.hide_in_width,
	        separator = " ",
	        separator_highlight = { colors.bg1, colors.bg1 },
	        highlight = { colors.green, colors.bg1, "bold" }
	    }
	}
	
	gls.right[8] = {
	    Space = {
	        provider = function() return "  " end,
	        highlight = { colors.bg1, colors.bg1, "bold" }
	    }
	}
	
	gls.short_line_left[1] = {
	    BufferType = {
	        provider = "FileTypeName",
	        separator = " ",
	        separator_highlight = { colors.bg1, colors.bg1 },
	        highlight = { colors.blue, colors.bg1, "bold" }
	    }
	}
	
	gls.short_line_left[2] = {
	    SFileName = {
	        provider = "SFileName",
	        condition = condition.buffer_not_empty,
	        highlight = { colors.fg, colors.bg1, "bold" }
	    }
	}
	
	gls.short_line_right[1] = {
	    BufferIcon = { provider = "BufferIcon", highlight = { colors.fg, colors.bg1 } }
	}
end

return M
