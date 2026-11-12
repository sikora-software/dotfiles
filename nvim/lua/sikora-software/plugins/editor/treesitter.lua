vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" } })

local ts = require("nvim-treesitter")
if not ts.install then
	-- The old `master` branch is still on disk (e.g. right after pulling this config)
	vim.notify("nvim-treesitter: run :PackUpdate nvim-treesitter, confirm with :w, then restart", vim.log.levels.WARN)
	return
end

-- Parsers, installed to ~/.local/share/nvim/site (does nothing if already installed).
-- They are updated by :TSUpdate after each plugin update (see `builds` in pack.lua).
ts.install({
	"lua",
	"rust",
	"javascript",
	"typescript",
	"html",
	"css",
	"scss",
	"tsx",
	"astro",
	"angular",
	"svelte",
	"json",
	"sql",
	"toml",
	"markdown",
	"markdown_inline",
	"jsdoc",
	"c_sharp",
})

-- Highlighting and indentation for every filetype that has a parser.
-- Runs one tick after the file is shown: compiling a language's highlight queries takes
-- ~100 ms the first time per session, so the text appears first and the colours right after.
local max_filesize = 100 * 1024 -- 100 KB: no highlighting for larger files
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("sikora-software.treesitter", { clear = true }),
	callback = function(args)
		local buf = args.buf
		vim.schedule(function()
			if not vim.api.nvim_buf_is_valid(buf) then
				return
			end
			local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
			local ok, has_parser = pcall(vim.treesitter.language.add, lang or "")
			if not (lang and ok and has_parser) then
				return
			end

			local stat_ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
			if not (stat_ok and stats and stats.size > max_filesize) then
				vim.treesitter.start(buf, lang)
			end

			-- only check that indent rules exist (compiling them here would cost ~10 ms)
			if #vim.treesitter.query.get_files(lang, "indents") > 0 then
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end)
	end,
})
