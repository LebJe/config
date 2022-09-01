local au = require("au")

local M = {}

local Loclist = require("sidebar-nvim.components.loclist")
local loclist = Loclist:new({})
local severityLevel = { "Error", "Warning", "Info", "Information", "Hint" }
local icons = {
	Error = "",
	Warning = "",
	Info = "",
	information = "",
	Hint = "",
}

function M.getDiagnostics()
	local diagnostics = vim.fn["CocAction"]("diagnosticList")
	local currentBuffer = vim.api.nvim_get_current_buf()
	local currentBufferFilepath = vim.api.nvim_buf_get_name(currentBuffer)
	local currentBufferFilename = vim.fn.fnamemodify(currentBufferFilepath, ":t")

	local openBuffers = vim.api.nvim_list_bufs()

	local loclistItems = {}

	if type(diagnostics) ~= "table" then
		return
	end

	for _, diag in pairs(diagnostics) do
		if currentBufferFilepath == diag.file then
			local message = diag.message
			message = message:gsub("\n", " ")

			local severity = diag.severity
			local code = diag.code

			if severity ~= nil then
				local icon = icons[severity]

				local left = {}

				if icon ~= nil then
					table.insert(left, { text = icon .. " ", hl = "SidebarNvimLspDiagnostics" .. severity })
				end

				if code ~= vim.NIL and code ~= nil then
					table.insert(left, { text = code .. " ", hl = "SidebarNvimLspDiagnosticsCode" })
				end

				table.insert(left, {
					text = diag.lnum + 1,
					hl = "SidebarNvimLspDiagnosticsLineNumber",
				})

				table.insert(left, { text = ":" })

				table.insert(left, {
					text = (diag.col + 1) .. " ",
					hl = "SidebarNvimLspDiagnosticsColNumber",
				})

				table.insert(left, { text = message })

				table.insert(loclistItems, {
					group = currentBufferFilename,
					left = left,
					lnum = diag.lnum + 1,
					col = diag.col + 1,
					filepath = currentBufferFilepath,
				})

				-- table.insert(loclistItems, {
				-- 	group = currentBufferFilename,
				-- 	left = {
				-- 		{ text = "  " .. diag.source },
				-- 	},
				-- 	lnum = diag.lnum + 1,
				-- 	col = diag.col + 1,
				-- 	filepath = currentBufferFilepath,
				-- })
			end
		end
	end

	loclist:set_items(loclistItems, { remove_groups = true })
end

M.diagnosticsSection = {
	title = "Diagnostics",
	icon = "",
	setup = function(_)
		local cocDiagChange = vim.api.nvim_create_augroup("SidebarDiagnosticsCocDiagChange", { clear = true })
		vim.api.nvim_create_autocmd("User", {
			pattern = "CocDiagnosticChange",
			group = cocDiagChange,
			callback = function(_)
				M.getDiagnostics()
			end,
		})
	end,
	update = function(_)
		M.getDiagnostics()
	end,
	draw = function(ctx)
		local lines = {}
		local hl = {}

		loclist:draw(ctx, lines, hl)

		if lines == nil or #lines == 0 then
			return "<no diagnostics>"
		else
			return { lines = lines, hl = hl }
		end
	end,
	highlights = {
		groups = {
			--CocD
		},
		links = {
			SidebarNvimLspDiagnosticsError = "LspDiagnosticsDefaultError",
			SidebarNvimLspDiagnosticsWarning = "LspDiagnosticsDefaultWarning",
			SidebarNvimLspDiagnosticsInfo = "CocInfoSign",
			SidebarNvimLspDiagnosticsHint = "CocHintSign",
			SidebarNvimLspDiagnosticsCode = "SidebarNvimSectionTitle",
			--SidebarNvimLspDiagnosticsInfo = "LspDiagnosticsDefaultInformation",
			--SidebarNvimLspDiagnosticsHint = "LspDiagnosticsDefaultHint",
			SidebarNvimLspDiagnosticsLineNumber = "SidebarNvimLineNr",
			SidebarNvimLspDiagnosticsColNumber = "SidebarNvimLineNr",
		},
	},
	bindings = {
		["e"] = function(line)
			local location = loclist:get_location_at(line)
			if location == nil then
				return
			end
			-- TODO: I believe there is a better way to do this, but I haven't had the time to do investigate
			vim.cmd("wincmd p")
			vim.cmd("e " .. location.filepath)
			vim.fn.cursor(location.lnum, location.col)
		end,
	},
}

return M
