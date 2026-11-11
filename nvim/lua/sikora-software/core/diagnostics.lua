-- Diagnostics from language servers and nvim-lint
vim.diagnostic.config({
	-- update_in_insert = true,
	-- Off: tiny-inline-diagnostic shows the messages.
	-- virtual_text = {
	-- 	source = true,
	-- 	prefix = "●",
	-- },
	virtual_text = false,
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
	-- [d / ]d (Neovim's default keys) jump to the previous/next diagnostic and show it in popup
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
		end,
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

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
