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

		vim.diagnostic.config({
			-- update_in_insert = true,
			virtual_text = {
				source = true,
				prefix = "●",
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "󰌶",
					[vim.diagnostic.severity.INFO] = "",
				},
				-- linehl = {
				--   [vim.diagnostic.severity.ERROR] = "ErrorMsg",
				--   [vim.diagnostic.severity.WARN] = "WarningMsg",
				--   [vim.diagnostic.severity.HINT] = "HintMsg",
				--   [vim.diagnostic.severity.INFO] = "InfoMsg",
				-- },
				-- numhl = {
				--   [vim.diagnostic.severity.ERROR] = "ErrorMsg",
				--   [vim.diagnostic.severity.WARN] = "WarningMsg",
				--   [vim.diagnostic.severity.HINT] = "HintMsg",
				--   [vim.diagnostic.severity.INFO] = "InfoMsg",
				-- },
			},
			float = {
				-- border = "rounded",
				source = true,
				-- header = "",
				-- prefix = "",
			},
		})

		-- Add related information to diagnostics
		local original = vim.lsp.handlers["textDocument/publishDiagnostics"]
		vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
			for _, item in ipairs(result.diagnostics) do
				if item.relatedInformation and #item.relatedInformation > 0 then
					for _, k in ipairs(item.relatedInformation) do
						if k.location then
							local tail = vim.fn.fnamemodify(vim.uri_to_fname(k.location.uri), ":t")
							k.message = tail
								.. "("
								.. (k.location.range.start.line + 1)
								.. ", "
								.. (k.location.range.start.character + 1)
								.. "): "
								.. k.message

							if k.location.uri == vim.uri_from_bufnr(0) then
								table.insert(result.diagnostics, {
									code = item.code,
									message = k.message,
									range = k.location.range,
									severity = vim.lsp.protocol.DiagnosticSeverity.Hint,
									source = item.source,
									relatedInformation = {},
								})
							end
						end
						item.message = item.message .. "\n\n" .. k.message
					end
				end
			end
			original(_, result, ctx, config)
		end

		-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		-- 	border = "rounded", -- You can use "single", "double", "rounded", "solid", or "shadow"
		-- })

		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
	end,
}
