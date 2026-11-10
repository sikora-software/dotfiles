return {
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				disable_filetype = { "spectre_panel" },
			})
		end,
	},
}
