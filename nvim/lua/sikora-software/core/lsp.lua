vim.lsp.enable({
	"angularjs",
	"astro",
	"cssls",
	"html",
	"jsonls",
	"lua_ls",
	"roslyn_ls",
	"rust_analyzer",
	-- "svelte",
	"vtsls",
})

-- Keymaps, only in buffers that have a language server attached.
-- K (hover) is not mapped here: Neovim maps it to hover by default in LSP buffers.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("sikora-software.lsp", { clear = true }),
	callback = function(args)
		local function map(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
		end

		map("<leader>gd", vim.lsp.buf.definition, "Go to definition")
		map("<leader>gD", vim.lsp.buf.declaration, "Go to declaration")
		map("<leader>gr", "<cmd>FzfLua lsp_references<CR>", "References")
		map("<leader>gi", vim.lsp.buf.implementation, "Go to implementation")
		map("<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>", "Code actions")
		map("<leader>ih", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, "Toggle inlay hints (all buffers)")
	end,
})
