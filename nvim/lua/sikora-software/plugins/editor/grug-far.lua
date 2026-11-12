vim.pack.add({ "https://github.com/MagicDuck/grug-far.nvim" })

-- VS Code-style search & replace panel: separate Search / Replace / Files Filter / Paths fields,
-- results in a buffer. <leader>fs shows and hides the same panel, so your search stays as you left it.
-- In the panel (local leader is \ by default): <Enter> open match, \r replace, \c close, \t history.
-- grug-far loads its code only when used, so no setup() call is needed.
local name = "far"

vim.keymap.set("n", "<leader>fs", function()
	local grug_far = require("grug-far")
	if grug_far.has_instance(name) then
		grug_far.toggle_instance({ instanceName = name })
		return
	end
	-- First time this session: start from your last search (it's kept across restarts)
	local last = grug_far.get_last_history_entry() or {}
	grug_far.open({
		instanceName = name,
		staticTitle = "Find and Replace",
		prefills = {
			search = last.search,
			replacement = last.replacement,
			filesFilter = last.filesFilter,
			flags = last.flags,
			paths = last.paths,
		},
	})
end, { desc = "Search & replace panel (keeps your search)" })

-- grug-far adds a search to its history only after a replace/sync or when the panel is closed (\c).
-- Also add it when Neovim quits, so the next <leader>fs brings it back.
vim.api.nvim_create_autocmd("VimLeavePre", {
	group = vim.api.nvim_create_augroup("sikora-software.grug-far", { clear = true }),
	callback = function()
		local grug_far = package.loaded["grug-far"]
		if not (grug_far and grug_far.has_instance(name)) then
			return
		end
		local instance = grug_far.get_instance(name)
		local buf = instance:get_buf()
		-- line 1 of the panel is the Search field: nothing to keep if it's empty
		if not (instance:is_valid() and (vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] or "") ~= "") then
			return
		end
		local file = vim.fn.stdpath("state") .. "/grug-far/history"
		local before = vim.uv.fs_stat(file)
		instance:history_add()
		-- the history file is written asynchronously: give it up to a second before Neovim exits
		vim.wait(1000, function()
			local now = vim.uv.fs_stat(file)
			return now ~= nil and (before == nil or now.mtime.sec ~= before.mtime.sec or now.mtime.nsec ~= before.mtime.nsec)
		end, 10)
	end,
})
