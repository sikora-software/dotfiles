-- Install: :MasonInstall astro-language-server
-- astro-ls needs the path to TypeScript's lib folder (tsdk) from the project's node_modules.
local function typescript_lib(root_dir)
	for _, node_modules in ipairs(vim.fs.find("node_modules", { path = root_dir, upward = true, limit = math.huge })) do
		local lib = vim.fs.joinpath(node_modules, "typescript", "lib")
		if vim.uv.fs_stat(lib) then
			return lib
		end
	end
	return ""
end

return {
	cmd = { "astro-ls", "--stdio" },
	filetypes = { "astro" },
	root_markers = { "package.json", "tsconfig.json", ".git" },
	init_options = { typescript = {} },
	before_init = function(_, config)
		config.init_options.typescript.tsdk = config.init_options.typescript.tsdk or typescript_lib(config.root_dir)
	end,
}
