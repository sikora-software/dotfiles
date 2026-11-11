vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move between splits using Ctrl + {h,j,k,l}
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Split resize
vim.keymap.set("", "<leader>>", "10<C-w>>")
vim.keymap.set("", "<leader><", "10<C-w><")
vim.keymap.set("", "<leader>+", "5<C-w>+")
vim.keymap.set("", "<leader>-", "5<C-w>-")

-- Split buffer and navigate to new buffer
vim.keymap.set("n", "<C-w>s", "<C-w>s<C-w>j")
vim.keymap.set("n", "<C-w>v", "<C-w>v<C-w>l")

-- Move selected text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Merge with line below, but keep cursor at the begining
vim.keymap.set("n", "J", "mzJ`z")

-- Move cursor down/up, but keep it on the center of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Jump to next/previous match, but keep cursor at the center of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste from clipboard, but not override it
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to OS clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")

-- vim.keymap.set("n", "Q", "<nop>")

-- Replace current text
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Preview vim config
vim.keymap.set("n", "<leader>vim", "<cmd>e ~/.config/nvim/lua/sikora-software<CR>")

-- Source config (only in nvim config)
vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("source %")
end)

vim.keymap.set("n", "<leader>rp", function()
	print(vim.fn.expand("%"))
end, {
	desc = "Show relative file path",
})

-- Insert new line without entering insert mode
vim.keymap.set("n", "<CR>", "m`o<Esc>``")
vim.keymap.set("n", "<S-CR>", "m`O<Esc>``")

vim.keymap.set("x", "<leader>r", '"zy:%s/\\V<C-R>z//gc<Left><Left><Left>', {
	noremap = true,
	silent = false,
	desc = "Interactive replace selection",
})
