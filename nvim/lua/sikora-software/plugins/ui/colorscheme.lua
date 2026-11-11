-- -- rose-pine
-- vim.pack.add({ { src = "https://github.com/rose-pine/neovim", name = "rose-pine" } })
-- require("rose-pine").setup({
-- 	dark_variant = "moon",
-- 	styles = {
-- 		bold = true,
-- 		italic = false,
-- 		transparency = true,
-- 	},
-- })
-- vim.cmd("colorscheme rose-pine")

-- -- catppuccin
-- vim.pack.add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } })
-- require("catppuccin").setup({
-- 	transparent_background = true,
-- })
-- vim.cmd.colorscheme("catppuccin")
-- vim.o.background = "dark"

-- -- tokyonight
-- vim.pack.add({ "https://github.com/folke/tokyonight.nvim" })
-- require("tokyonight").setup({
-- 	transparent = true,
-- 	styles = {
-- 		sidebars = "transparent",
-- 		--   floats = "transparent",
-- 	},
-- })
-- vim.cmd.colorscheme("tokyonight-night")
-- vim.o.background = "dark"

-- -- nightfox
-- vim.pack.add({ "https://github.com/EdenEast/nightfox.nvim" })
-- require("nightfox").setup({
-- 	style = "carbonfox",
-- 	transparent = true,
-- 	term_colors = true,
-- })
-- vim.cmd.colorscheme("carbonfox")
-- vim.o.background = "dark"

vim.pack.add({ "https://github.com/Mofiqul/vscode.nvim" })

local c = require("vscode.colors").get_colors()
require("vscode").setup({
	-- Alternatively set style in setup
	-- style = 'light'

	-- Enable transparent background
	transparent = true,

	-- Enable italic comment
	italic_comments = false,

	-- Underline `@markup.link.*` variants
	underline_links = true,

	-- Disable nvim-tree background color
	disable_nvimtree_bg = true,

	-- Apply theme colors to terminal
	terminal_colors = true,

	-- Override colors (see ./lua/vscode/colors.lua)
	color_overrides = {
		-- vscLineNumber = "#FFFFFF",
	},

	-- Override highlight groups (see ./lua/vscode/theme.lua)
	group_overrides = {
		-- this supports the same val table as vim.api.nvim_set_hl
		-- use colors from this colorscheme by requiring vscode.colors!
		-- Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
	},
})
vim.cmd.colorscheme("vscode")
vim.o.background = "dark"
