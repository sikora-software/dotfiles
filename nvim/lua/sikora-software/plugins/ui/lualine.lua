vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

local lualine_c = {
	-- {
	--   function()
	--     return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	--   end,
	-- },
	{ "filename", path = 1 }, -- Shows the full path to the file
}

require("lualine").setup({
	options = {
		theme = "auto",
	},
	sections = {
		lualine_c = lualine_c,
	},
	inactive_sections = {
		lualine_c = lualine_c,
	},
})
