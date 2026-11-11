-- Default branch, no version: wait till new 0.7.0 release to put it back on semver
vim.pack.add({ "https://github.com/nvim-mini/mini.indentscope" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"Trouble",
		"alpha",
		"dashboard",
		"fzf",
		"help",
		"lazy",
		"mason",
		"neo-tree",
		"notify",
		"snacks_dashboard",
		"snacks_notif",
		"snacks_terminal",
		"snacks_win",
		"toggleterm",
		"trouble",
	},
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "SnacksDashboardOpened",
	callback = function(data)
		vim.b[data.buf].miniindentscope_disable = true
	end,
})

require("mini.indentscope").setup({
	symbol = "▏",
	-- symbol = "│",
	options = { try_as_border = true },
})
