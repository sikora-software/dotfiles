return {
	{
		"ibhagwan/fzf-lua",
		-- dependencies = { "echasnovski/mini.icons" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
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

			vim.cmd("FzfLua register_ui_select")

			-- keymaps
			vim.keymap.set("n", "<leader>ff", fzf.files, {})
			vim.keymap.set("n", "<leader>fg", fzf.live_grep, {})
			vim.keymap.set("n", "<leader>fm", fzf.marks, {})
			vim.keymap.set("n", "<leader>gs", fzf.git_status, {})
			vim.keymap.set("n", "<leader>gq", function()
				require("fzf-lua").live_grep({ actions = { ["default"] = require("fzf-lua").actions.file_edit_or_qf } })
			end, { desc = "Live grep into quickfix" })
		end,
	},
}
