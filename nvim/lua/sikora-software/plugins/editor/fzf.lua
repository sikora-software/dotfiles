vim.pack.add({
	-- "https://github.com/echasnovski/mini.icons",
	"https://github.com/ibhagwan/fzf-lua",
})

-- Set up right after startup instead of during it (~9 ms, mostly loading fzf-lua itself).
-- That's still before you can press anything, so the keymaps, :FzfLua and vim.ui.select all use these options.
vim.api.nvim_create_autocmd("UIEnter", {
	once = true,
	callback = vim.schedule_wrap(function()
		local fzf = require("fzf-lua")

		fzf.setup({
			defaults = {
				winopts = {
					preview = {
						layout = "vertical", -- horizontal|vertical|flex
					},
				},
				keymap = {
					builtin = {
						["<C-d>"] = "preview-page-down",
						["<C-u>"] = "preview-page-up",
					},
					fzf = {
						["ctrl-q"] = "select-all+accept",
					},
				},
			},

			files = {
				formatter = "path.filename_first",
				fzf_opts = { ["--scheme"] = "history", ["--tiebreak"] = "begin,length" },
			},

			grep = {
				rg_opts = "--sort path --column --line-number --no-heading --color=always -S",
				fzf_opts = {
					["--no-sort"] = "",
					["--tiebreak"] = "index",
					["--delimiter"] = ":",
					["--nth"] = "2..",
					["--layout"] = "reverse",
				},
			},
		})

		fzf.register_ui_select() -- same as :FzfLua register_ui_select
	end),
})

-- keymaps (fzf-lua is only loaded when one is pressed)
vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files()
end, {})
vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").live_grep({ resume = true })
end, { desc = "Live grep (resumes last search)" })
vim.keymap.set("n", "<leader>fm", function()
	require("fzf-lua").marks()
end, {})
vim.keymap.set("n", "<leader>gs", function()
	require("fzf-lua").git_status()
end, {})
vim.keymap.set("n", "<leader>gq", function()
	require("fzf-lua").live_grep({ actions = { ["default"] = require("fzf-lua").actions.file_edit_or_qf } })
end, { desc = "Live grep into quickfix" })
