vim.g.mapleader = " "

local default_opts = {
    noremap = false,
    silent = false
} -- Options for keymaps

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, default_opts)

-- Move between splits using Ctrl + {h,j,k,l}
vim.keymap.set("n", "<C-h>", "<C-w>h", default_opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", default_opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", default_opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", default_opts)

-- Split resize
vim.keymap.set("", "<leader>>", "10<C-w>>", default_opts)
vim.keymap.set("", "<leader><", "10<C-w><", default_opts)
vim.keymap.set("", "<leader>+", "5<C-w>+", default_opts)
vim.keymap.set("", "<leader>-", "5<C-w>-", default_opts)

-- Split buffer and navigate to new buffer
vim.keymap.set("n", "<C-w>s", "<C-w>s<C-w>j", default_opts)
vim.keymap.set("n", "<C-w>v", "<C-w>v<C-w>l", default_opts)

-- Move selected text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", default_opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", default_opts)

-- Merge with line below, but keep cursor at the begining
vim.keymap.set("n", "J", "mzJ`z", default_opts)

-- Move cursor down/up, but keep it on the center of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz", default_opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", default_opts)

-- Jump to next/previous match, but keep cursor at the center of the screen
vim.keymap.set("n", "n", "nzzzv", default_opts)
vim.keymap.set("n", "N", "Nzzzv", default_opts)

-- Paste from clipboard, but not override it
vim.keymap.set("x", "<leader>p", [["_dP]], default_opts)

-- Copy to OS clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], default_opts)
vim.keymap.set("n", "<leader>Y", [["+Y]], default_opts)

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], default_opts)

vim.keymap.set("i", "<C-c>", "<Esc>", default_opts)

-- vim.keymap.set("n", "Q", "<nop>", default_opts)

-- Replace current text
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], default_opts)

-- Preview vim config
vim.keymap.set("n", "<leader>vim", "<cmd>e ~/.config/nvim/lua/sikora-software<CR>", default_opts)

-- Source config (only in nvim config)
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("source %")
end, default_opts)

vim.keymap.set("n", "<leader>rp", function()
    print(vim.fn.expand("%"))
end, {
    desc = "Show relative file path"
})

-- Insert new line without entering insert mode
vim.keymap.set("n", "<CR>", "m`o<Esc>``")
vim.keymap.set("n", "<S-CR>", "m`O<Esc>``")

vim.keymap.set("x", "<leader>r", '"zy:%s/\\V<C-R>z//gc<Left><Left><Left>', {
    noremap = true,
    silent = false,
    desc = "Interactive replace selection"
})
