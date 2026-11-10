return {
	"williamboman/mason.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		-- "L3MON4D3/LuaSnip",
		-- "saadparwaiz1/cmp_luasnip",
	},

	config = function()
		-- local cmp = require("cmp")
		-- local cmp_lsp = require("cmp_nvim_lsp")
		-- local capabilities = vim.tbl_deep_extend(
		-- 	"force",
		-- 	{},
		-- 	vim.lsp.protocol.make_client_capabilities(),
		-- 	cmp_lsp.default_capabilities()
		-- )

		require("mason").setup()

		-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
		--
		-- cmp.setup({
		-- 	snippet = {
		-- 		expand = function(args)
		-- 			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		-- 		end,
		-- 	},
		-- 	mapping = cmp.mapping.preset.insert({
		-- 		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		-- 		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		-- 		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		-- 		["<C-Space>"] = cmp.mapping.complete(),
		-- 	}),
		-- 	sources = cmp.config.sources({
		-- 		{ name = "nvim_lsp" },
		-- 		{ name = "luasnip" }, -- For luasnip users.
		-- 	}, {
		-- 		{ name = "buffer" },
		-- 	}),
		-- })

		-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		-- 	border = "rounded", -- You can use "single", "double", "rounded", "solid", or "shadow"
		-- })
	end,
}
