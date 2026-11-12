vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

local lint = require("lint")

lint.linters_by_ft = {
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	svelte = { "eslint_d" },
	astro = { "eslint_d" },
}

-- Some ESLint setups print text before eslint_d's JSON result (Nx prints "NX Falling back to
-- ts-node ..." each time eslint_d starts), which makes parsing fail. Parse from the JSON line on.
local eslint_d = lint.linters.eslint_d
local parse_eslint_d = eslint_d.parser
eslint_d.parser = function(output, bufnr, ...)
	local json_start = output:find("^%[") or output:find("\n%[")
	if json_start then
		output = output:sub(json_start):gsub("^\n", "")
	end
	return parse_eslint_d(output, bufnr, ...)
end

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

local function has_eslint_config()
	local root = vim.fs.root(0, { "package.json" }) or vim.fn.getcwd()

	-- Check for disable marker
	if vim.fn.filereadable(root .. "/.nolint") == 1 then
		return false
	end

	local configs = {
		-- flat config (ESLint 9+)
		"eslint.config.js",
		"eslint.config.mjs",
		"eslint.config.cjs",
		"eslint.config.ts",
		"eslint.config.mts",
		"eslint.config.cts",
		-- legacy config
		".eslintrc",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.json",
		".eslintrc.yml",
		".eslintrc.yaml",
	}
	for _, name in ipairs(configs) do
		if vim.fn.filereadable(root .. "/" .. name) == 1 then
			return true
		end
	end
	return false
end

vim.api.nvim_create_autocmd({
	-- "BufEnter",
	"FileType", -- on open, once the filetype is known (BufReadPost runs before detection)
	"BufWritePost",
	"InsertLeave",
	"TextChanged",
	-- "TextChangedI", -- after every keystroke in insert mode; InsertLeave lints when you're done
}, {
	group = lint_augroup,
	callback = function()
		if has_eslint_config() then
			lint.try_lint()
		end
	end,
})

vim.keymap.set("n", "<leader>ll", function()
	lint.try_lint()
end, { desc = "Trigger linting for current file" })

-- vim.keymap.set("n", "<leader>lf", function()
-- 	local file = vim.fn.expand("%:p")
-- 	vim.cmd("!eslint_d --fix " .. file)
-- end, { desc = "Fix ESLint errors with eslint_d", silent = true })

vim.keymap.set("n", "<leader>lf", function()
	local bufnr = vim.api.nvim_get_current_buf()
	-- eslint_d fixes the file on disk, so save unsaved changes first: the fix applies to what you see
	if vim.bo[bufnr].modified then
		vim.cmd("silent write")
	end
	local file = vim.api.nvim_buf_get_name(bufnr)
	local before = vim.uv.fs_stat(file)

	vim.system({ "eslint_d", "--fix", file }, { text = true }, function(result)
		-- Runs once, after eslint_d has exited (its output can start with extra lines, e.g. from Nx)
		vim.schedule(function()
			if result.code >= 2 then -- 1 only means "problems left that can't be fixed automatically"
				vim.notify("ESLint error:\n" .. (result.stderr ~= "" and result.stderr or result.stdout), vim.log.levels.ERROR)
				return
			end
			local after = vim.uv.fs_stat(file)
			-- Compare to the nanosecond: a fix within the same second as the last save must still reload
			if not (before and after and (before.mtime.sec ~= after.mtime.sec or before.mtime.nsec ~= after.mtime.nsec)) then
				vim.notify("ESLint: nothing to fix", vim.log.levels.INFO)
			elseif vim.api.nvim_buf_is_valid(bufnr) and not vim.bo[bufnr].modified then
				vim.api.nvim_buf_call(bufnr, function()
					vim.cmd("edit!") -- reload the fixed file
				end)
				vim.notify("ESLint fixed and buffer reloaded", vim.log.levels.INFO)
			else
				vim.notify("ESLint fixed the file, but you edited the buffer meanwhile: :e! shows the fix", vim.log.levels.WARN)
			end
		end)
	end)
end, { desc = "Fix ESLint errors with eslint_d", silent = true })
