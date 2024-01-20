local U = require("utilities")
local npairs = require("nvim-autopairs")
local g = vim.g

_G.Completion = {}

Completion.CompletionConfirm = function()
	if vim.fn["coc#pum#visible"]() ~= 0 then
		return vim.fn["coc#pum#confirm"]()
	else
		return npairs.autopairs_cr()
	end
end

function Completion.CheckBackspace()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

-- Make <CR> either accept selected completion item and notify coc.nvim to format, or use nvim-autopairs.
U.map("i", "<CR>", Completion.CompletionConfirm, { expr = true, noremap = true, replace_keycodes = false })

-- Use <c-space> to trigger completion.
U.map("i", "<c-space>", vim.fn["coc#refresh"], { expr = true, silent = true, noremap = true })

-- Insert <tab> when previous text is space, refresh completion if not.
U.map(
	"i",
	"<TAB>",
	'coc#pum#visible() ? coc#pum#next(1) : "<TAB>"',
	{ silent = true, noremap = true, expr = true, replace_keycodes = false }
)
U.map(
	"i",
	"<S-TAB>",
	[[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]],
	{ silent = true, noremap = true, expr = true, replace_keycodes = false }
)

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
U.map("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
U.map("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

-- GoTo code navigation.
U.map("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
U.map("n", "gd", "<Plug>(coc-definition)", { silent = true })
U.map("n", "gi", "<Plug>(coc-implementation)", { silent = true })
U.map("n", "gr", "<Plug>(coc-references)", { silent = true })

-- Use K to show documentation in preview window.
U.map("n", "K", function()
	local cw = vim.fn.expand("<cword>")
	if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
		vim.api.nvim_command("h " .. cw)
	elseif vim.api.nvim_eval("coc#rpc#ready()") then
		vim.fn.CocActionAsync("doHover")
	else
		vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
	end
end, { noremap = true, silent = true })

-- Highlight the symbol and its references when holding the cursor.
U.autocmd("CursorHold", {
	pattern = "*",
	callback = function(_)
		vim.fn.CocActionAsync("highlight")
	end,
	desc = "Highlight the symbol and its references when holding the cursor.",
})

-- Symbol renaming.
U.map("n", "<leader>rn", "<Plug>(coc-rename)", {})

-- Formatting selected code.
U.map("x", "<leader>f", "<Plug>(coc-format-selected)", {})
U.map("n", "<leader>f", "<Plug>(coc-format-selected)", {})

local cocOverrides = vim.api.nvim_create_augroup("CocOverrides", { clear = true })

U.autocmd("FileType", {
	pattern = "typescript,json",
	group = cocOverrides,
	callback = function(_)
		vim.api.nvim_buf_set_option(0, "formatexpr", "CocAction('formatSelected')")
	end,
})

U.autocmd("User", {
	pattern = "CocJumpPlaceholder",
	group = cocOverrides,
	callback = function(_)
		vim.fn.CocActionAsync("showSignatureHelp")
	end,
})

-- Applying codeAction to the selected region.
--U.map("x", "<leader>a", "<Plug>(coc-codeaction-selected)", {})

-- Show CodeAction for symbol under cursor.
U.map("n", "<leader>a", "<Plug>(coc-codeaction-cursor)", {})

-- Example: `<leader>aap` for current paragraph
U.map("n", "<leader>a", "<Plug>(coc-codeaction-selected)", {})

-- Remap keys for applying codeAction to the current buffer.
U.map("n", "<leader>ac", "<Plug>(coc-codeaction)", {})

-- Apply AutoFix to problem on the current line.
U.map("n", "<leader>qf", "<Plug>(coc-fix-current)", {})

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
U.map("x", "if", "<Plug>(coc-funcobj-i)", {})
U.map("o", "if", "<Plug>(coc-funcobj-i)", {})
U.map("x", "af", "<Plug>(coc-funcobj-a)", {})
U.map("o", "af", "<Plug>(coc-funcobj-a)", {})
U.map("x", "ic", "<Plug>(coc-classobj-i)", {})
U.map("o", "ic", "<Plug>(coc-classobj-i)", {})
U.map("x", "ac", "<Plug>(coc-classobj-a)", {})
U.map("o", "ac", "<Plug>(coc-classobj-a)", {})

-- Use CTRL-S for selections ranges.
-- Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
U.map("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
U.map("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })

-- Add `:Format` command to format current buffer.
U.userCmd("Format", function(_)
	vim.fn.CocAction("format")
end, { desc = "Format buffer using Language Server" })

-- Add `:Fold` command to fold current buffer.
U.userCmd("Fold", "call CocAction('fold', <f-args>)", { nargs = "?", desc = "fold buffer using Language Server" })

--vim.api.nvim_create_user_command("Fold", function(args) vim.fn.CocAction("fold", args.fargs) end, { desc = "fold buffer using Language Server" })

--  Add `:OR` command for organize imports of the current buffer.
U.userCmd("OR", function(_)
	vim.fn.CocAction("runCommand", "editor.action.organizeImport")
end, { desc = "Organize import statements" })

-- Mappings for CoCList
--
-- Show all diagnostics.
U.map("n", "<space>a", ":<C-u>CocList diagnostics<cr>", { noremap = true, silent = true, nowait = true })

-- Manage extensions.
U.map("n", "<space>e", ":<C-u>CocList extensions<cr>", { noremap = true, silent = true, nowait = true })

-- Show commands.
U.map("n", "<space>c", ":<C-u>CocList commands<cr>", { noremap = true, silent = true, nowait = true })

-- Find symbol of current document.
U.map("n", "<space>o", ":<C-u>CocList outline<cr>", { noremap = true, silent = true, nowait = true })

-- Search workspace symbols.
U.map("n", "<space>s", ":<C-u>CocList -I symbols<cr>", { noremap = true, silent = true, nowait = true })

-- Do default action for next item.
U.map("n", "<space>j", ":<C-u>CocNext<CR>", { noremap = true, silent = true, nowait = true })

-- Do default action for previous item.
U.map("n", "<space>k", ":<C-u>CocPrev<CR>", { noremap = true, silent = true, nowait = true })

-- Resume latest coc list.
U.map("n", "<space>p", ":<C-u>CocListResume<CR>", { noremap = true, silent = true, nowait = true })

g.coc_global_extensions = {
	"coc-clangd",
	"coc-cmake",
	"coc-css",
	"coc-go",
	"coc-html",
	"coc-json",
	"coc-lua",
	"coc-marketplace",
	"coc-pyright",
	"coc-prettier",
	"coc-rust-analyzer",
	"coc-snippets",
	"coc-sh",
	"coc-stylua",
	"coc-spell-checker",
	"coc-sql",
	--"coc-sourcekit",
	"https://github.com/LebJe/coc-sourcekit",
	--"coc-symbol-line",
	"coc-toml",
	"coc-tsserver",
	"coc-yaml",
}

--vim.g.coc_default_semantic_highlight_groups = true

-- Use <Tab> for jump to next placeholder, it's default of coc.nvim
vim.g.coc_snippet_next = "<Tab>"

-- Use <S-Tab> for jump to previous placeholder, it's default of coc.nvim
vim.g.coc_snippet_prev = "<S-Tab>"

-- Format current buffer using :Prettier.
U.userCmd("Prettier", function(_)
	vim.cmd("CocCommand prettier.formatFile")
end, {
	desc = "Format buffer using Prettier.",
})

--- Open CocOutline if it's closed, and close it if it's open.
function OpenCocOutline()
	local winID = vim.fn["coc#window#find"]("cocViewId", "OUTLINE")

	if winID == -1 then
		vim.fn.CocActionAsync("showOutline", 1)
	else
		vim.fn["coc#window#close"](winID)
	end
end
-- Open Document Symbol Outline with <C-i>.
U.map("n", "<C-i>", function()
	OpenCocOutline()
end, { noremap = true, silent = true })

-- Close document symbol outline if it's the last window.
-- U.autocmd("BufEnter", {
-- 	pattern = "*",
-- 	callback = function(_)
-- 	vim.cmd([[
--       if &filetype ==# 'coctree' && winnr('$') == 1
--         if tabpagenr('$') != 1
--           close
--         else
--           bdelete
--         endif
--       endif
-- 	]])
-- 	end,
-- })

g.vim_json_syntax_conceal = 0
g.coc_default_semantic_highlight_groups = 1

-- Highlights #bf68d9
vim.api.nvim_set_hl(0, "@variable", { fg = "#47959e" })

local inlayHintBGColor = "#303030"

vim.api.nvim_set_hl(0, "CocInlayHintParameter", { fg = "#72b83d", bg = inlayHintBGColor })
vim.api.nvim_set_hl(0, "CocInlayHint", { fg = "#bf68d9", bg = inlayHintBGColor })

vim.api.nvim_set_hl(0, "CocMenuSel", { bg = "#042d6e", ctermbg = 237 })

vim.api.nvim_set_hl(0, "CocSemIdentifier", { link = "@variable" })
--vim.api.nvim_set_hl(0, "CocSemStruct", { link = "CocSemType" })
vim.api.nvim_set_hl(0, "CocSemOperator", { link = "CocSemFunction" })
vim.api.nvim_set_hl(0, "CocTreeSelected", { link = "CocMenuSel" })

local enableLS = vim.api.nvim_create_augroup("EnableLS", { clear = true })

U.autocmd("BufEnter", {
	pattern = "*",
	group = enableLS,
	callback = function(_)
		-- Enable clangd if we are not inside a Swift package or editing a swift file, otherwise, enable SourceKit-LSP.
		if vim.fn.filereadable(vim.loop.cwd() .. "/Package.swift") == 1 or vim.fn.expand("%:e") == "swift" then
			vim.fn["coc#config"]("sourcekit", { enabled = true })
			vim.fn["coc#config"]("clangd", { enabled = false })
		else
			vim.fn["coc#config"]("clangd", { enabled = true })
			vim.fn["coc#config"]("sourcekit", { enabled = false })
		end
	end,
})

--vim.o.tabline = '%!v:lua.symbol_line()'
--vim.o.winbar = '%{%get(b:, "coc_symbol_line", "")%}'
