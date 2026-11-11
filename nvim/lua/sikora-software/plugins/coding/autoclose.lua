vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })

require("nvim-autopairs").setup({
	disable_filetype = { "spectre_panel" },
})
