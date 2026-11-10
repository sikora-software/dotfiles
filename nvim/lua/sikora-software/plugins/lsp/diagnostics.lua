return {
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup({
				transparent_bg = true,
				options = {
					show_source = {
						enabled = true,
						-- Show source only when multiple sources exist for the same diagnostic
						-- if_many = true,
					},
					multilines = {
						-- Enable multiline diagnostic messages
						enabled = true,

						-- Always show messages on all lines for multiline diagnostics
						always_show = true,

						-- Trim whitespaces from the start/end of each line
						trim_whitespaces = false,

						-- Replace tabs with this many spaces in multiline diagnostics
						tabstop = 4,
					},
					show_all_diags_on_cursorline = true,
				},
			})
			vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
		end,
	},
}
