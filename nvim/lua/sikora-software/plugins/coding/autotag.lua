vim.pack.add({ "https://github.com/windwp/nvim-ts-autotag" })

require("nvim-ts-autotag").setup({
	filetypes = {
		"html",
		"xml",
		"javascript",
		"typescript",
		"typescriptreact",
		"tsx",
		"vue",
		"svelte",
		"css",
		"scss",
		"less",
		"markdown",
		"json",
		"yaml",
		"html",
	},
})
