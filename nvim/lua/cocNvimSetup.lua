local U = require("utilities")
local npairs = require("nvim-autopairs")
local g = vim.g

function CompletionConfirm()
	if vim.fn["coc#pum#visible"]() ~= 0 then
		return vim.fn["coc#pum#confirm"]()
	else
		return npairs.autopairs_cr()
	end
end

-- Make <CR> either accept selected completion item and notify coc.nvim to format, or use nvim-autopairs.
vim.keymap.set("i", "<CR>", CompletionConfirm, { expr = true, silent = true, noremap = true })

-- Use <c-space> to trigger completion.
vim.keymap.set("i", "<c-space>", vim.fn["coc#refresh"], { expr = true, silent = true, noremap = true })
vim.cmd([[
function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

]])

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
U.map("n", "K", ":call ShowDocumentation()<CR>", { noremap = true, silent = true })

vim.cmd([[
function! ShowDocumentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction
]])

-- Highlight the symbol and its references when holding the cursor.
vim.api.nvim_create_autocmd("CursorHold", {
	pattern = "*",
	callback = function(_)
		vim.fn.CocActionAsync("highlight")
	end,
})

-- Symbol renaming.
U.map("n", "<leader>rn", "<Plug>(coc-rename)", {})

-- Formatting selected code.
U.map("x", "<leader>f", "<Plug>(coc-format-selected)", {})
U.map("n", "<leader>f", "<Plug>(coc-format-selected)", {})

local cocOverrides = vim.api.nvim_create_augroup("CocOverrides", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "typescript,json",
	group = cocOverrides,
	callback = function(_)
		vim.api.nvim_buf_set_option(0, "formatexpr", "CocAction('formatSelected')")
	end,
})

vim.api.nvim_create_autocmd("User", {
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
vim.api.nvim_create_user_command("Format", function(_)
	vim.fn.CocAction("format")
end, { desc = "Format buffer using Language Server" })

-- Add `:Fold` command to fold current buffer.
vim.cmd([[command! -nargs=? Fold :call CocAction('fold', <f-args>)]])
--vim.api.nvim_create_user_command("Fold", function(args) vim.fn.CocAction("fold", args.fargs) end, { desc = "fold buffer using Language Server" })

--  Add `:OR` command for organize imports of the current buffer.
vim.api.nvim_create_user_command("OR", function(_)
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
	"coc-json",
	"coc-yaml",
	"coc-toml",
	"coc-tsserver",
	"coc-html",
	"coc-css",
	"coc-clangd",
	"coc-pyright",
	"coc-go",
	"coc-snippets",
	"coc-prettier",
	"coc-marketplace",
	"coc-sh",
	"coc-spell-checker",
	"coc-rust-analyzer",
	"coc-lua",
	"coc-sourcekit",
}

g.coc_default_semantic_highlight_groups = true

-- Use <Tab> for jump to next placeholder, it's default of coc.nvim
g.coc_snippet_next = "<Tab>"

-- Use <S-Tab> for jump to previous placeholder, it's default of coc.nvim
g.coc_snippet_prev = "<S-Tab>"

-- Format current buffer using :Prettier.
vim.api.nvim_create_user_command("Prettier", function(_)
	vim.cmd("CocCommand prettier.formatFile")
end, {
	desc = "Format buffer using Prettier.",
})

-- Open Document Symbol Outline with <C-i>.
vim.keymap.set("n", "<C-i>", function()
	local winID = vim.fn["coc#window#find"]("cocViewId", "OUTLINE")

	if winID == -1 then
		vim.fn.CocActionAsync("showOutline", 1)
	else
		vim.fn["coc#window#close"](winID)
	end
end, { noremap = true, silent = true })

-- Close document symbol outline if it's the last window.
-- vim.api.nvim_create_autocmd("BufEnter", {
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

vim.cmd("hi link CocSemIdentifer TSVariable")
vim.cmd("hi CocMenuSel ctermbg=237 guibg=#042d6e")
vim.cmd("hi link CocTreeSelected CocMenuSel")

-- Enable clangd if we are not inside a Swift package.
if vim.fn.filereadable(vim.loop.cwd() .. "/Package.swift") then
	vim.fn["coc#config"]("clangd", { enabled = false })
else
	vim.fn["coc#config"]("clangd", { enabled = true })
end
