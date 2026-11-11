-- NOTE: as under lazy.nvim, snacks is only loaded and set up the first time one of
-- its keys below is pressed, so indent/input/notifier/scope/scroll/words stay off
-- until then. Set it up at startup to use them all the time.
vim.pack.add({ "https://github.com/folke/snacks.nvim" }, { load = function() end })

local function snacks()
	if not package.loaded["snacks"] then
		vim.cmd.packadd("snacks.nvim")
		require("snacks").setup({
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = false }, -- we set this in options.lua
			-- toggle = { map = LazyVim.safe_keymap_set },
			words = { enabled = true },
		})
	end
	return Snacks
end

-- stylua: ignore start
vim.keymap.set("n", "<leader>n", function()
	snacks()
	if Snacks.config.picker and Snacks.config.picker.enabled then
		Snacks.picker.notifications()
	else
		Snacks.notifier.show_history()
	end
end, { desc = "Notification History" })
vim.keymap.set("n", "<leader>un", function() snacks().notifier.hide() end, { desc = "Dismiss All Notifications" })
-- stylua: ignore end

-- -- dashboard: add to the setup({ ... }) options above
-- 	dashboard = {
-- 		preset = {
-- 			pick = function(cmd, opts)
-- 				return LazyVim.pick(cmd, opts)()
-- 			end,
-- 			header = [[
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
-- 		},
-- 	},
