return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				current_line_blame_opts = {
					delay = 0, -- milliseconds, default is 1000
				},
			})

			-- Gitsigns keymaps
			local opts = { noremap = true, silent = true }

			-- Jump between hunks (works correctly)
			vim.keymap.set("n", "]g", function()
				if vim.wo.diff then
					return "]g"
				end
				-- schedule to avoid interfering with mapping evaluation / recursion
				vim.schedule(function()
					require("gitsigns").next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, silent = true })

			vim.keymap.set("n", "[g", function()
				if vim.wo.diff then
					return "[g"
				end
				vim.schedule(function()
					require("gitsigns").prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, silent = true })

			-- Popup what's changed in a hunk under cursor
			vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", opts)
			vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", {})

			-- Stage/reset individual hunks under cursor
			-- vim.keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", opts)
			-- vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", opts)
			-- vim.keymap.set("n", "<leader>gu", ":Gitsigns undo_stage_hunk<CR>", opts)

			-- Stage/reset all hunks in file
			-- vim.keymap.set("n", "<leader>gS", ":Gitsigns stage_buffer<CR>", opts)
			-- vim.keymap.set("n", "<leader>gU", ":Gitsigns reset_buffer_index<CR>", opts)
			-- vim.keymap.set("n", "<leader>gR", ":Gitsigns reset_buffer<CR>", opts)
		end,
	},
}
