require("plugins")
local settings = require("settings")
local npairs = require("nvim-autopairs")

function CompletionConfirm()
	if vim.fn["coc#pum#visible"]() ~= 0 then
		return vim.fn["coc#pum#confirm"]()
	else
		return npairs.autopairs_cr()
	end
end

settings.setOptions()
settings.setKeymaps()
