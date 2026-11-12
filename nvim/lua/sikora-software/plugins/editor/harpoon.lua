vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
})

-- Loaded and set up on the first use of one of the keys below (~8 ms less at startup)
local is_setup = false
local function harpoon()
	local h = require("harpoon")
	if not is_setup then
		h:setup({
			settings = {
				save_on_toggle = true,
			},
		})
		is_setup = true
	end
	return h
end

vim.keymap.set("n", "<leader>H", function()
	harpoon():list():add()
end, { desc = "Harpoon File" })

vim.keymap.set("n", "<leader>h", function()
	-- Menu as wide as the current window minus 4 columns (full width, capped)
	harpoon().ui:toggle_quick_menu(harpoon():list(), {
		ui_width_ratio = 1,
		ui_max_width = vim.api.nvim_win_get_width(0) - 4,
	})
end, { desc = "Harpoon Quick Menu" })

for i = 1, 5 do
	vim.keymap.set("n", "<leader>" .. i, function()
		harpoon():list():select(i)
	end, { desc = "Harpoon to File " .. i })
end
