vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
	indent = { enabled = true, scope = { enabled = false } },
	input = { enabled = true },
	notifier = { enabled = true },
	scope = { enabled = false },
	scroll = { enabled = false },
	statuscolumn = { enabled = false }, -- we set this in options.lua
	-- toggle = { map = LazyVim.safe_keymap_set },
	words = { enabled = true },
})

-- stylua: ignore start
vim.keymap.set("n", "<leader>n", function()
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
