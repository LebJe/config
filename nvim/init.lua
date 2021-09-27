require("plugins")
local settings = require("settings")

function CompletionConfirm()
	local npairs = require("nvim-autopairs")

	if vim.fn.pumvisible() ~= 0 then
		return npairs.esc("<cr>")
	else
		return npairs.autopairs_cr()
	end
end

settings.setOptions()
settings.setKeymaps()

---- Get information about debuggable executables from `swift package`.
--function DapConfigFromSwiftPackage()
--	if vim.loop.fs_access(vim.loop.cwd() .. "/Package.swift", "r") then
--		local dap = require("dap")
--		local lunajson = require("lunajson")
--
--		local fh = io.popen("swift package describe --type json")
--		local data = fh:read("*all")
--
--		fh:close()
--
--		local tbl = lunajson.decode(data)
--
--		local configArray = {}
--		local libLLDB = require("settings").libLLDB
--
--		if tbl ~= nil then
--			for _, value in ipairs(tbl.products) do
--				if value.type.executable ~= nil then
--					-- table.insert(
--					--	configArray,
--					configArray = {
--						{
--							type = "vscode_lldb",
--							adapter = "vscode_lldb",
--							request = "launch",
--							name = value.targets[0] .. "- Debug Executable " .. value.name,
--							program = "${workspaceFolder}/.build/debug/value",
--							liblldb = libLLDB,
--						},
--					}
--					-- )
--				end
--			end
--		else
--			print("Error in JSON!")
--		end
--
--		-- Setup configurations.
--		dap.configurations.swift = configArray
--	end
--end
