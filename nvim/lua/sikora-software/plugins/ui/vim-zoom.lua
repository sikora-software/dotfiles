-- Zoom the current window to full size and back, built into snacks.nvim (ui/snacks.lua)
vim.keymap.set("n", "<C-w>m", function()
	Snacks.zen.zoom()
end, { desc = "Zoom window (toggle)" })
