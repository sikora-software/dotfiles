-- vim.pack.add({ "https://github.com/uga-rosa/ccc.nvim" })
-- require("ccc").setup({
--   -- your configuration comes here
--   -- or leave it empty to use the default settings
--   -- refer to the configuration section below
-- })

vim.pack.add({ "https://github.com/norcalli/nvim-colorizer.lua" })

require("colorizer").setup({
	-- Enable colorizer for certain file types (or use "all" for all files)
	"*", -- Highlight colors in all files by default
	css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in CSS
	html = { names = true }, -- Enable named colors in HTML
})

-- vim.pack.add({ "https://github.com/eero-lehtinen/oklch-color-picker.nvim" })
-- require("oklch-color-picker").setup({})
-- -- One handed keymap recommended, you will be using the mouse
-- vim.keymap.set("n", "<leader>v", "<cmd>ColorPickOklch<cr>", { desc = "Color pick under cursor" })
