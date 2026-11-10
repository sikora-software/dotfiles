return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	-- Nested lists have equal priority; earlier lists win over later ones.
	root_markers = {
		{ ".emmyrc.json", ".luarc.json", ".luarc.jsonc" },
		{ ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml" },
		{ ".git" },
	},
	settings = {
		Lua = {
			-- runtime = { version = "Lua 5.1" },
			diagnostics = {
				globals = { "vim" },
			},
			codeLens = { enable = true },
			hint = { enable = true, semicolon = "Disable" },
		},
	},
}
