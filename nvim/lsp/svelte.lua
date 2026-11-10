-- Install: :MasonInstall svelte-language-server
return {
	cmd = { "svelteserver", "--stdio" },
	filetypes = { "svelte" },
	root_markers = { "package.json", "svelte.config.js", ".git" },
	on_attach = function(client)
		-- Tell the server when .js/.ts files change, so imports in .svelte files stay up to date
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = { "*.js", "*.ts" },
			group = vim.api.nvim_create_augroup("sikora-software.svelte", {}),
			callback = function(ctx)
				client:notify("$/onDidChangeTsOrJsFile", { uri = vim.uri_from_fname(ctx.match) })
			end,
		})
	end,
}
