vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	-- "https://github.com/L3MON4D3/LuaSnip",
	-- "https://github.com/saadparwaiz1/cmp_luasnip",
})

-- local cmp = require("cmp")
-- local cmp_lsp = require("cmp_nvim_lsp")
-- local capabilities = vim.tbl_deep_extend(
-- 	"force",
-- 	{},
-- 	vim.lsp.protocol.make_client_capabilities(),
-- 	cmp_lsp.default_capabilities()
-- )

require("mason").setup()

-- Install anything missing in the background (on a new machine: everything)
local ensure_installed = {
	-- language servers, configured in lsp/
	"angular-language-server",
	"css-lsp",
	"html-lsp",
	"json-lsp",
	"lua-language-server",
	"roslyn-language-server",
	"vtsls",
	-- formatters and linters, used by conform and nvim-lint
	"eslint_d",
	"prettier",
	"stylua",
	"taplo", -- toml
}
local registry = require("mason-registry")
registry.refresh(vim.schedule_wrap(function()
	for _, name in ipairs(ensure_installed) do
		local pkg = registry.get_package(name)
		if not pkg:is_installed() and not pkg:is_installing() then
			vim.notify("Mason: installing " .. name)
			pkg:install(
				{},
				vim.schedule_wrap(function(success)
					vim.notify(
						("Mason: %s %s"):format(name, success and "installed" or "failed to install"),
						success and vim.log.levels.INFO or vim.log.levels.ERROR
					)
				end)
			)
		end
	end
end))

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
