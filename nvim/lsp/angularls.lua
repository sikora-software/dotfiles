-- ngserver has to be told where to find `typescript` and `@angular/language-service`:
-- first in the project's node_modules, then in the copy bundled next to the
-- ngserver executable (e.g. the one Mason installed).
local function node_modules_dirs(root_dir)
	local dirs = {}
	local project = vim.fs.joinpath(root_dir, "node_modules")
	if vim.uv.fs_stat(project) then
		table.insert(dirs, project)
	end
	local exe = vim.fn.exepath("ngserver")
	if exe ~= "" then
		-- <prefix>/node_modules/@angular/language-server/bin/ngserver  ->  <prefix>/node_modules
		local bin_dir = vim.fs.dirname(vim.uv.fs_realpath(exe) or exe)
		local bundled = vim.fs.normalize(vim.fs.joinpath(bin_dir, "../../.."))
		if vim.uv.fs_stat(bundled) then
			table.insert(dirs, bundled)
		end
	end
	return dirs
end

-- "@angular/core": "^19.2.1" in package.json  ->  "19.2.1"
local function angular_core_version(root_dir)
	local ok, content = pcall(vim.fn.readblob, vim.fs.joinpath(root_dir, "package.json"))
	if not ok then
		return ""
	end
	local decoded, json = pcall(vim.json.decode, content)
	if not decoded or type(json) ~= "table" then
		return ""
	end
	local version = (json.dependencies or {})["@angular/core"] or (json.devDependencies or {})["@angular/core"] or ""
	return version:match("%d+%.%d+%.%d+") or ""
end

return {
	cmd = function(dispatchers, config)
		local root_dir = (config and config.root_dir) or vim.fn.getcwd()
		local dirs = node_modules_dirs(root_dir)
		local ng_dirs = vim.tbl_map(function(dir)
			return vim.fs.joinpath(dir, "@angular/language-server/node_modules")
		end, dirs)
		return vim.lsp.rpc.start({
			"ngserver",
			"--stdio",
			"--tsProbeLocations",
			table.concat(dirs, ","),
			"--ngProbeLocations",
			table.concat(ng_dirs, ","),
			"--angularCoreVersion",
			angular_core_version(root_dir),
		}, dispatchers)
	end,
	filetypes = { "typescript", "html", "typescriptreact", "htmlangular" },
	root_markers = { "angular.json", "nx.json" },
	-- Only start inside an Angular workspace, not for every .ts/.html file
	workspace_required = true,
}
