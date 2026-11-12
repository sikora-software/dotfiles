vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true

-- vim.opt.hlsearch = false
-- vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
-- vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

if vim.fn.getenv("TERM_PROGRAM") == "ghostty" then
	vim.opt.title = true
	vim.opt.titlestring = "%{fnamemodify(getcwd(), ':t')}"
end

-- EditorConfig (built into Neovim): ignore invalid end_of_line values such as `true` silently,
-- like VS Code does, instead of warning on every file. Valid values (lf, crlf, cr) still apply.
local editorconfig = require("editorconfig")
local set_end_of_line = editorconfig.properties.end_of_line
editorconfig.properties.end_of_line = function(bufnr, val, opts)
	if val == "lf" or val == "crlf" or val == "cr" then
		set_end_of_line(bufnr, val, opts)
	end
end
