local U = require("utilities")
local au = require("au")
local g = vim.g

-- Use <c-space> to trigger completion.

vim.cmd([[
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
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
U.map("n", "K", ":call Show_documentation()<CR>", { noremap = true, silent = true })

vim.cmd([[
function! Show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction
]])

-- Highlight the symbol and its references when holding the cursor.
au.CursorHold = function()
	vim.fn.CocActionAsync("highlight")
end

-- Symbol renaming.
U.map("n", "<leader>rn", "<Plug>(coc-rename)", {})

-- Formatting selected code.
U.map("x", "<leader>f", "<Plug>(coc-format-selected)", {})
U.map("n", "<leader>f", "<Plug>(coc-format-selected)", {})

au.group("CocOverrides", function(grp)
	grp.FileType = {
		"typescript,json",
		function()
			vim.api.nvim_buf_set_option(0, "formatexpr", "CocAction('formatSelected')")
		end,
	}
	grp.User = {
		"CocJumpPlaceholder",
		function()
			vim.fn.CocActionAsync("showSignatureHelp")
		end,
	}
end)

-- Applying codeAction to the selected region.
U.map("x", "<leader>a", "<Plug>(coc-codeaction-selected)", {})

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
vim.cmd([[command! -nargs=0 Format :call CocAction('format')]])

-- Add `:Fold` command to fold current buffer.
vim.cmd([[command! -nargs=? Fold :call CocAction('fold', <f-args>)]])
--  Add `:OR` command for organize imports of the current buffer.
vim.cmd([[command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')]])

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

function MakeSymbol(isNext)
	if isNext then
		if vim.api.nvim_eval("pumvisible()") == 1 then
			return "<C-n>"
		else
			return "<Tab>"
		end
	else
		if vim.api.nvim_eval("pumvisible()") == 1 then
			return "<C-p>"
		else
			return "<S-Tab>"
		end
	end
end

-- U.map('i', '<Tab>', MakeSymbol(true), { noremap = true, expr = true })
-- U.map('i', '<S-Tab>', MakeSymbol(false), { noremap = true, expr = true })

-- Use <Tab> and <S-Tab> to navigate the completion list:
vim.cmd([[
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
]])

-- Use <Tab> for jump to next placeholder, it's default of coc.nvim
g.coc_snippet_next = "<Tab>"

-- Use <S-Tab> for jump to previous placeholder, it's default of coc.nvim
g.coc_snippet_prev = "<S-Tab>"

-- Format current buffer using :Prettier.
vim.cmd([[command! -nargs=0 Prettier :CocCommand prettier.formatFile]])

g.vim_json_syntax_conceal = 0

vim.cmd("hi link CocSemIdentifer TSVariable")

if vim.fn.filereadable(vim.loop.cwd() .. "/Package.swift") then
	vim.fn["coc#config"]("clangd", { enabled = false })
else
	vim.fn["coc#config"]("clangd", { enabled = true })
end
