return {
	cmd = { "vtsls", "--stdio" },
	init_options = { hostInfo = "neovim" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	-- Project root: nearest lockfile, else nearest .git, else the current directory.
	root_dir = function(bufnr, on_dir)
		local markers = { { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }, { ".git" } }
		on_dir(vim.fs.root(bufnr, markers) or vim.fn.getcwd())
	end,
}
