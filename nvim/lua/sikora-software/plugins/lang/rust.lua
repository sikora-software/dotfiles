vim.pack.add({ { src = "https://github.com/saecki/crates.nvim", version = "stable" } })

vim.api.nvim_create_autocmd("BufRead", {
	pattern = "Cargo.toml",
	once = true,
	callback = function()
		require("crates").setup()
	end,
})
