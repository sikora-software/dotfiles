-- LazyGit in a floating window, built into snacks.nvim (ui/snacks)
-- it also themes lazygit to match the colorscheme. Needs the 'lazygit' program (brew install lazygit)

vim.keymap.set("n", "<leader>lg", function()
	Snacks.lazygit()
end, { desc = "LazyGit" })
