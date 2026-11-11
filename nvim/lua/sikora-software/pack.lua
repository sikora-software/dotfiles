-- Plugins managed by Neovim's built-in package manager (vim.pack).
-- Every file in plugins/<category>/ calls vim.pack.add() and then sets its plugin up.
-- Files load in alphabetical order, category by category, in the order listed here.
local categories = { "ui", "git", "lang", "lsp", "coding", "editor" }

-- Build steps, run after a plugin is installed or updated.
-- Registered before any vim.pack.add(): on a new machine every plugin from
-- nvim-pack-lock.json is installed during the very first add() call.
local builds = {
	-- a string is a shell command, run in the plugin's folder after install and update
	["markdown-preview.nvim"] = "cd app && npm install && rm -f package-lock.json && git restore .",
	-- a function gets the PackChanged event and decides itself
	["nvim-treesitter"] = function(ev)
		-- after updates only: on first install, ensure_installed fetches the parsers
		if ev.data.kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
}
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if type(builds[name]) == "function" then
			builds[name](ev)
		elseif builds[name] and (kind == "install" or kind == "update") then
			vim.system({ "sh", "-c", builds[name] }, { cwd = ev.data.path }, function(result)
				vim.schedule(function()
					local ok = result.code == 0
					vim.notify(
						("%s: build %s"):format(name, ok and "finished" or "failed\n" .. result.stderr),
						ok and vim.log.levels.INFO or vim.log.levels.ERROR
					)
				end)
			end)
		end
	end,
})

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

-- :PackUpdate [names]  download updates and show them for review: ]] / [[ jump between
--                      plugins, K shows details, :w applies, :q cancels
vim.api.nvim_create_user_command("PackUpdate", function(cmd)
	vim.pack.update(#cmd.fargs > 0 and cmd.fargs or nil)
end, {
	nargs = "*",
	complete = function()
		return vim.tbl_map(function(plugin)
			return plugin.spec.name
		end, vim.pack.get(nil, { info = false }))
	end,
	desc = "Update plugins (review, then :w to apply or :q to cancel)",
})

-- :PackClean  delete plugins that are still on disk but no longer added by this config
vim.api.nvim_create_user_command("PackClean", function()
	local unused = vim.iter(vim.pack.get(nil, { info = false }))
		:filter(function(plugin)
			return not plugin.active
		end)
		:map(function(plugin)
			return plugin.spec.name
		end)
		:totable()
	if #unused == 0 then
		return vim.notify("PackClean: nothing to delete")
	end
	if vim.fn.confirm("Delete from disk?\n\n" .. table.concat(unused, "\n"), "&Yes\n&No", 2) == 1 then
		vim.pack.del(unused)
	end
end, { desc = "Delete plugins that are no longer in the config" })
