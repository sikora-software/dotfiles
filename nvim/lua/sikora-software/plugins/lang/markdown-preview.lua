vim.g.mkdp_filetypes = { "markdown" }
vim.pack.add({ "https://github.com/iamcco/markdown-preview.nvim" })

vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", { desc = "Markdown preview" })
