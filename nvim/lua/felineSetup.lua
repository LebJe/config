local M = {}
local feline = require("feline")

-- From https://github.com/glepnir/galaxyline.nvim/blob/d544cb9d0b56f6ef271db3b4c3cf19ef665940d5/lua/galaxyline/provider_diagnostic.lua#L5
--- Get number of `diagType` diagnostic from CoC.
--- @param diagType string CoC diagnostic name
--- @return integer
local function getCoCDiagnostic(diagType)
	local has_info, info = pcall(vim.api.nvim_buf_get_var, 0, "coc_diagnostic_info")
	if not has_info then
		return "0"
	end

	if info[diagType] ~= nil and type(info[diagType]) == "number" then
		if info[diagType] > 0 then
			return info[diagType]
		end
	end

	return 0
end

--- @return string
local function getCocSymbolLine()
	local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
	local ok, line = pcall(vim.api.nvim_buf_get_var, bufnr, "coc_symbol_line")
	return ok and line or ""
end

-- Left Components

local viMode = {
	provider = {
		name = "vi_mode",
		opts = {
			show_mode_name = true,
		},
	},
	hl = function()
		return {
			name = require("feline.providers.vi_mode").get_mode_highlight_name(),
			fg = require("feline.providers.vi_mode").get_mode_color(),
			bg = "bg_d",
			style = "bold",
		}
	end,
	icon = " ",
	right_sep = {
		str = "  ",
		hl = {
			bg = "bg_d",
		},
	},
}

local fileInfo = {
	provider = {
		name = "file_info",
	},
	hl = {
		bg = "bg_d",
	},
	right_sep = {
		str = " ",
		hl = {
			bg = "bg_d",
		},
	},
}

-- Git - Branch
local gitBranch = {
	provider = "git_branch",
	icon = {
		str = " ",
		hl = {
			fg = "blue",
			bg = "bg",
			style = "bold",
		},
	},
	hl = {
		bg = "bg",
		--style = "bold",
	},
	right_sep = {
		str = " ",
		bg = "bg",
	},
}

-- Git - Diff Information

local gitDiffAdded = {
	provider = "git_diff_added",
	hl = {
		fg = "green",
		bg = "bg",
	},
	right_sep = {
		str = " ",
		bg = "bg",
	},
}

local gitDiffModified = {
	provider = "git_diff_changed",
	hl = {
		fg = "orange",
		bg = "bg",
	},
	right_sep = {
		str = " ",
		bg = "bg",
	},
}

local gitDiffRemoved = {
	provider = "git_diff_removed",
	hl = {
		fg = "red",
		bg = "bg",
	},
	right_sep = {
		str = " ",
		bg = "bg",
	},
}

-- Middle Components

local LSPStatus = {
	provider = getCocSymbolLine,
	update = getCocSymbolLine,
	enabled = function()
		local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
		local ok, _ = pcall(vim.api.nvim_buf_get_var, bufnr, "coc_symbol_line")
		return ok
	end,
	right_sep = {
		str = "  ",
		bg = "bg",
	},
}

local LSPDiagnosticError = {
	provider = function()
		if vim.fn.exists("*coc#rpc#start_server") == 1 then
			return tostring(getCoCDiagnostic("error"))
		else
			return "0"
		end
	end,
	update = function()
		return vim.fn.exists("*coc#rpc#start_server") == 1
	end,
	hl = {
		fg = "red",
		bg = "bg",
	},
	icon = {
		str = " ",
		hl = {
			fg = "red",
			bg = "bg",
		},
	},
	right_sep = {
		str = "  ",
		bg = "bg",
	},
}

local LSPDiagnosticWarning = {
	provider = function()
		if vim.fn.exists("*coc#rpc#start_server") == 1 then
			return tostring(getCoCDiagnostic("warning"))
		else
			return "0"
		end
	end,
	update = function()
		return vim.fn.exists("*coc#rpc#start_server") == 1
	end,
	hl = {
		fg = "yellow",
		bg = "bg",
	},
	icon = {
		str = " ",
		hl = {
			fg = "yellow",
			bg = "bg",
		},
	},
	right_sep = {
		str = "  ",
		bg = "bg",
	},
}

local LSPDiagnosticHint = {
	provider = function()
		if vim.fn.exists("*coc#rpc#start_server") == 1 then
			return tostring(getCoCDiagnostic("hint"))
		else
			return "0"
		end
	end,
	update = function()
		return vim.fn.exists("*coc#rpc#start_server") == 1
	end,
	hl = {
		fg = "cyan",
		bg = "bg",
	},
	icon = {
		str = " ",
		hl = {
			fg = "cyan",
			bg = "bg",
		},
	},
	right_sep = {
		str = "  ",
		bg = "bg",
	},
}

local LSPDiagnosticInfo = {
	provider = function()
		if vim.fn.exists("*coc#rpc#start_server") == 1 then
			return tostring(getCoCDiagnostic("info"))
		else
			return "0"
		end
	end,
	update = function()
		return vim.fn.exists("*coc#rpc#start_server") == 1
	end,
	hl = {
		fg = "blue",
		bg = "bg",
	},
	icon = {
		str = " ",
		hl = {
			fg = "blue",
			bg = "bg",
		},
	},
	right_sep = {
		str = "  ",
		bg = "bg",
	},
}

-- Right Components

local lineTotal = {
	provider = function()
		return vim.api.nvim_call_function("line", { "$" }) .. " lines"
	end,
	update = function()
		return vim.api.nvim_call_function("line", { "$" }) .. " lines"
	end,
	hl = {
		bg = "bg_d",
	},
	right_sep = {
		str = "  ",
		hl = {
			bg = "bg_d",
		},
	},
}

local cursorPosition = {
	provider = "position",
	hl = {
		bg = "bg_d",
	},
	right_sep = {
		str = "  ",
		hl = {
			bg = "bg_d",
		},
	},
}

local linePercentage = {
	provider = "line_percentage",
	hl = {
		bg = "bg_d",
	},
	right_sep = {
		str = "  ",
		hl = {
			bg = "bg_d",
		},
	},
}

local fileSize = {
	provider = "file_size",
	hl = {
		bg = "bg_d",
	},
	right_sep = {
		str = "  ",
		hl = {
			bg = "bg_d",
		},
	},
}

local fileEncoding = {
	provider = "file_encoding",
	hl = {
		bg = "bg_d",
	},
	right_sep = {
		str = "  ",
		hl = {
			bg = "bg_d",
		},
	},
}

local fileFormat = {
	provider = "file_format",
	hl = {
		bg = "bg_d",
	},
	right_sep = {
		str = "  ",
		hl = {
			bg = "bg_d",
		},
	},
}

local component1 = {
	viMode,
	fileInfo,
	{
		provider = " ",
		hl = {
			fg = "bg_d",
			bg = "bg",
		},
	},
	gitBranch,
	gitDiffAdded,
	gitDiffModified,
	gitDiffRemoved,
}

local component2 = {
	LSPStatus,
	LSPDiagnosticError,
	LSPDiagnosticWarning,
	LSPDiagnosticHint,
	LSPDiagnosticInfo,
}

local component3 = {
	{
		provider = " ",
		left_sep = {
			str = "",
			hl = {
				fg = "bg_d",
				bg = "bg",
			},
		},
		hl = {
			bg = "bg_d",
		},
	},
	cursorPosition,
	lineTotal,
	linePercentage,
	fileSize,
	fileEncoding,
	fileFormat,
}

local activeComponents = {
	component1,
	component2,
	component3,
}

local components = {
	active = activeComponents,
	inactive = {
		{
			cursorPosition,
			lineTotal,
		},
	},
}

function M.configureStatusline()
	feline.setup({
		components = components,
	})

	feline.use_theme(require("onedark.palette").darker)
end

return M
