vim.pack.add({ "https://github.com/folke/zen-mode.nvim" })

vim.keymap.set("n", "<leader>zz", function()
	require("zen-mode").setup({
		window = {
			width = 90,
			options = {},
		},
	})
	require("zen-mode").toggle()
end)
