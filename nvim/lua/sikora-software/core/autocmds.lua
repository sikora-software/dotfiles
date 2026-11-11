-- Quickfix list: <CR> opens the entry, j/k preview entries while staying in the list
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function(args)
		local bufnr = args.buf
		vim.keymap.set("n", "<CR>", ":.cc<CR>", {
			buffer = bufnr,
			noremap = true,
			silent = true,
		})
		vim.keymap.set("n", "j", "j:.cc<CR><C-w>p", {
			buffer = bufnr,
			noremap = true,
			silent = true,
		})
		vim.keymap.set("n", "k", "k:.cc<CR><C-w>p", {
			buffer = bufnr,
			noremap = true,
			silent = true,
		})
	end,
})

local function line_number_colors()
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#00b7ff" }) -- Replace with desired color
	vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#6e7681" }) -- Above cursor
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#6e7681" }) -- Below cursor
end
line_number_colors()
vim.api.nvim_create_autocmd("ColorScheme", { callback = line_number_colors })
