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
