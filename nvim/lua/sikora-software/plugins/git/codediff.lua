vim.pack.add({ "https://github.com/esmuellert/codediff.nvim" })

-- Explorer: <CR> open, - stage/unstage, S / U stage / unstage all, X discard, R refresh.
-- Diff: ]c / [c next / previous change, ]f / [f next / previous file, t inline / side-by-side
-- q close
vim.keymap.set("n", "<leader>gc", "<cmd>CodeDiff<CR>", { desc = "Git changes" })
