return {
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	config = function()
	-- 		require("rose-pine").setup({
	-- 			dark_variant = "moon",
	-- 			styles = {
	-- 				bold = true,
	-- 				italic = false,
	-- 				transparency = true,
	-- 			},
	-- 		})
	-- 		vim.cmd("colorscheme rose-pine")
	-- 	end,
	-- },
	--  {
	--    "catppuccin/nvim",
	--    name = "catppuccin",
	--    priority = 1000,
	--    opts = {
	--      transparent_background = true,
	--    },
	--    config = function(_, opts)
	--      require("catppuccin").setup(opts)
	--      vim.cmd.colorscheme("catppuccin")
	--      vim.o.background = "dark"
	--    end,
	--  },
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {
	-- 		transparent = true,
	-- 		styles = {
	-- 			sidebars = "transparent",
	-- 			--   floats = "transparent",
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("tokyonight").setup(opts)
	-- 		vim.cmd.colorscheme("tokyonight-night")
	-- 		vim.o.background = "dark"
	-- 	end,
	-- },
	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {
	-- 		style = "carbonfox",
	-- 		transparent = true,
	-- 		term_colors = true,
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("nightfox").setup(opts)
	-- 		vim.cmd.colorscheme("carbonfox")
	-- 		vim.o.background = "dark"
	-- 	end,
	-- },
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
		config = function()
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
		end,
	},
}
