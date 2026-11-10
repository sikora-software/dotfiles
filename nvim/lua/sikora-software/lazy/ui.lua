return {
	-- {
	--   "folke/noice.nvim",
	--   event = "VeryLazy",
	--   opts = {
	--     lsp = {
	--       override = {
	--         ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	--         ["vim.lsp.util.stylize_markdown"] = true,
	--         ["cmp.entry.get_documentation"] = true,
	--       },
	--     },
	--     routes = {
	--       {
	--         filter = {
	--           event = "msg_show",
	--           any = {
	--             { find = "%d+L, %d+B" },
	--             { find = "; after #%d+" },
	--             { find = "; before #%d+" },
	--           },
	--         },
	--         view = "mini",
	--       },
	--     },
	--     presets = {
	--       bottom_search = true,
	--       command_palette = true,
	--       long_message_to_split = true,
	--     },
	--   },
	--   -- stylua: ignore
	--   keys = {
	--     { "<leader>sn",  "",                                                                            desc = "+noice" },
	--     { "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end,                 mode = "c",                              desc = "Redirect Cmdline" },
	--     { "<leader>snl", function() require("noice").cmd("last") end,                                   desc = "Noice Last Message" },
	--     { "<leader>snh", function() require("noice").cmd("history") end,                                desc = "Noice History" },
	--     { "<leader>sna", function() require("noice").cmd("all") end,                                    desc = "Noice All" },
	--     { "<leader>snd", function() require("noice").cmd("dismiss") end,                                desc = "Dismiss All" },
	--     { "<leader>snt", function() require("noice").cmd("pick") end,                                   desc = "Noice Picker (Telescope/FzfLua)" },
	--     { "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  silent = true,                           expr = true,              desc = "Scroll Forward",  mode = { "i", "n", "s" } },
	--     { "<c-b>",       function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,                           expr = true,              desc = "Scroll Backward", mode = { "i", "n", "s" } },
	--   },
	--   config = function(_, opts)
	--     -- HACK: noice shows messages from before it was enabled,
	--     -- but this is not ideal when Lazy is installing plugins,
	--     -- so clear the messages in this case.
	--     if vim.o.filetype == "lazy" then
	--       vim.cmd([[messages clear]])
	--     end
	--     require("noice").setup(opts)
	--   end,
	-- },

	-- icons
	{
		"echasnovski/mini.icons",
		lazy = true,
		opts = {
			file = {
				[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
				["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
			},
			filetype = {
				dotenv = { glyph = "", hl = "MiniIconsYellow" },
			},
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	-- ui components
	{ "MunifTanjim/nui.nvim", lazy = true },

	{
		"folke/snacks.nvim",
		opts = {
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = false }, -- we set this in options.lua
			-- toggle = { map = LazyVim.safe_keymap_set },
			words = { enabled = true },
		},
    -- stylua: ignore
    keys = {
      {
        "<leader>n",
        function()
          if Snacks.config.picker and Snacks.config.picker.enabled then
            Snacks.picker.notifications()
          else
            Snacks.notifier.show_history()
          end
        end,
        desc = "Notification History"
      },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    },
	},

	-- {
	-- 	"folke/snacks.nvim",
	-- 	opts = {
	-- 		dashboard = {
	-- 			preset = {
	-- 				pick = function(cmd, opts)
	-- 					return LazyVim.pick(cmd, opts)()
	-- 				end,
	-- 				header = [[
	--          ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
	--          ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
	--          ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
	--          ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
	--          ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
	--          ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
	--   ]],
	--          -- stylua: ignore
	--          ---@type snacks.dashboard.Item[]
	--          keys = {
	--            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
	--            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
	--            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
	--            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
	--            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
	--            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
	--            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
	--            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
	--            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
	--          },
	-- 			},
	-- 		},
	-- 	},
	-- },
	--

	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	main = "ibl",
	-- 	opts = {
	-- 		indent = {
	-- 			char = "│",
	-- 		},
	-- 		scope = {
	-- 			enabled = true,
	-- 			show_start = false,
	-- 			show_end = false,
	-- 		},
	-- 	},
	-- },

	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		opts = {
			symbol = "▏",
			-- symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"Trouble",
					"alpha",
					"dashboard",
					"fzf",
					"help",
					"lazy",
					"mason",
					"neo-tree",
					"notify",
					"snacks_dashboard",
					"snacks_notif",
					"snacks_terminal",
					"snacks_win",
					"toggleterm",
					"trouble",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "SnacksDashboardOpened",
				callback = function(data)
					vim.b[data.buf].miniindentscope_disable = true
				end,
			})
		end,
	},
}
