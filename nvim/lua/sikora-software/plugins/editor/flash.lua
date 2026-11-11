vim.pack.add({ "https://github.com/folke/flash.nvim" })

-- Set up once the UI is ready (what lazy.nvim called "VeryLazy")
vim.api.nvim_create_autocmd("UIEnter", {
	once = true,
	callback = vim.schedule_wrap(function()
		require("flash").setup({})
	end),
})

-- stylua: ignore start
vim.keymap.set({ "n", "x", "o" }, "<leader>s", function() require("flash").jump() end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "<leader>S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })
vim.keymap.set("c", "<c-s>", function() require("flash").toggle() end, { desc = "Toggle Flash Search" })
-- stylua: ignore end
