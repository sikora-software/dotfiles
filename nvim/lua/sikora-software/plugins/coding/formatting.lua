vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		liquid = { "prettier" },
		lua = { "stylua" },
		rust = { "rustfmt" },
		toml = { "taplo" },
	},
	-- format_on_save = {
	-- 	lsp_format = true,
	-- 	async = false,
	-- 	timeout_ms = 1000,
	-- },
})

vim.keymap.set({ "n", "v" }, "<leader>gf", function()
	conform.format({
		lsp_format = "fallback",
		async = false,
		timeout_ms = 1000,
	})
end, { desc = "Format file or range (in visual mode)" })
