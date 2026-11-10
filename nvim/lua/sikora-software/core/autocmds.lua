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
