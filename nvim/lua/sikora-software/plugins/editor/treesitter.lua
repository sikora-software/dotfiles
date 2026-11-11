vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" } })

-- Parsers are updated by :TSUpdate after each plugin update (see `builds` in pack.lua)
require("nvim-treesitter.configs").setup({
	ensure_installed = {
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
	},
	sync_install = false,
	highlight = {
		enable = true,
		disable = function(_, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
	},
	indent = { enable = true },
})
