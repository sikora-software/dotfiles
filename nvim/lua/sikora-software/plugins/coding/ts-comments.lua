vim.pack.add({ "https://github.com/folke/ts-comments.nvim" })

-- Set up once the UI is ready (what lazy.nvim called "VeryLazy")
vim.api.nvim_create_autocmd("UIEnter", {
	once = true,
	callback = vim.schedule_wrap(function()
		require("ts-comments").setup({})
	end),
})
