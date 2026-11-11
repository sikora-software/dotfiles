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
	"FileType",
	"BufWritePost",
	"InsertLeave",
	"TextChanged",
	-- "TextChangedI",
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
	local file = vim.fn.expand("%:p")
	local uv = vim.uv

	-- Get initial file modification time
	local before = uv.fs_stat(file)

	vim.system({ "eslint_d", "--fix", file }, {
		text = true,
		stdout = function(_)
			-- Get mod time after fix
			local after = uv.fs_stat(file)
			if before and after and before.mtime.sec ~= after.mtime.sec then
				vim.schedule(function()
					vim.cmd("checktime") -- check if file changed outside
					vim.cmd("edit!") -- force reload
					vim.notify("ESLint fixed and buffer reloaded", vim.log.levels.INFO)
				end)
			else
				vim.schedule(function()
					vim.notify("ESLint fixed (no reload needed)", vim.log.levels.INFO)
				end)
			end
		end,
		stderr = function(err)
			if err then
				vim.schedule(function()
					vim.notify("ESLint error:\n" .. err, vim.log.levels.ERROR)
				end)
			end
		end,
	})
end, { desc = "Fix ESLint errors with eslint_d", silent = true })
