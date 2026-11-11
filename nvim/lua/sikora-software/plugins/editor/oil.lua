vim.pack.add({
	-- icons: mini.icons (ui/mini-icons.lua)
	-- "https://github.com/nvim-tree/nvim-web-devicons", -- use if you prefer nvim-web-devicons
	"https://github.com/stevearc/oil.nvim",
})

require("oil").setup({
	-- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
	-- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
	default_file_explorer = false,
})
vim.keymap.set("n", "<leader>oi", require("oil").open, {})
