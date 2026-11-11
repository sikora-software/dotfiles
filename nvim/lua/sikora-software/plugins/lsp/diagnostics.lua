vim.pack.add({ "https://github.com/rachartier/tiny-inline-diagnostic.nvim" })

-- Set up once the UI is ready, to keep it out of startup time (what lazy.nvim called "VeryLazy")
vim.api.nvim_create_autocmd("UIEnter", {
	once = true,
	callback = vim.schedule_wrap(function()
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
	end),
})
