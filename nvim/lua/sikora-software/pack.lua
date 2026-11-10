-- Plugins managed by Neovim's built-in package manager (vim.pack).
-- Every file in plugins/<category>/ calls vim.pack.add() and then sets its plugin up.
-- Files load in alphabetical order, category by category, in the order listed here.
-- Categories not listed yet are still imported by lazy.nvim in lazy_init.lua.
local categories = { "git" }

local add = vim.pack.add
vim.pack.add = function(specs, opts)
	return add(specs, vim.tbl_extend("keep", opts or {}, { load = true }))
end

for _, category in ipairs(categories) do
	local files = {}
	for name, kind in vim.fs.dir(vim.fn.stdpath("config") .. "/lua/sikora-software/plugins/" .. category) do
		if kind == "file" and name:match("%.lua$") then
			table.insert(files, name:sub(1, -5))
		end
	end
	table.sort(files)
	for _, file in ipairs(files) do
		require(("sikora-software.plugins.%s.%s"):format(category, file))
	end
end

vim.pack.add = add
