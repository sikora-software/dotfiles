-- C# via Roslyn, Microsoft's language server (the engine behind VS Code's C# Dev Kit).
-- Install: :MasonInstall roslyn-language-server   (needs the .NET SDK)
-- Condensed from nvim-lspconfig's roslyn_ls: no Razor, no decompiled-source navigation.

local group = vim.api.nvim_create_augroup("sikora-software.roslyn", { clear = true })

-- Roslyn registers several diagnostic providers (syntax, compiler, analyzers);
-- ask each of them for fresh results.
local function refresh_diagnostics(client)
	local providers = client.dynamic_capabilities.capabilities.diagnosticProvider or {}
	for bufnr in pairs(client.attached_buffers) do
		if vim.api.nvim_buf_is_loaded(bufnr) then
			for _, provider in ipairs(providers) do
				client:request("textDocument/diagnostic", {
					identifier = provider.registerOptions.identifier,
					textDocument = vim.lsp.util.make_text_document_params(bufnr),
				}, nil, bufnr)
			end
		end
	end
end

local function apply(client, action)
	if action.edit then
		vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
	end
	if action.command then
		client:exec_cmd(action.command)
	end
end

local function notify_error(err)
	vim.notify("roslyn_ls: " .. (err.message or tostring(err)), vim.log.levels.ERROR)
end

return {
	cmd = { "roslyn-language-server", "--stdio", "--autoLoadProjects" },
	filetypes = { "cs" },

	-- Project root: the folder with the .sln/.slnx, else the one with the .csproj
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, function(name)
			return name:match("%.slnx?$") ~= nil
		end) or vim.fs.root(bufnr, function(name)
			return name:match("%.csproj$") ~= nil
		end)
		if root then
			on_dir(root)
		end
	end,

	-- Without this Roslyn sends no diagnostics
	capabilities = {
		textDocument = { diagnostic = { dynamicRegistration = true } },
	},

	handlers = {
		["workspace/projectInitializationComplete"] = function(_, _, ctx)
			vim.notify("Roslyn: project loaded", vim.log.levels.INFO)
			refresh_diagnostics(assert(vim.lsp.get_client_by_id(ctx.client_id)))
			return vim.NIL
		end,
	},

	on_attach = function(client, bufnr)
		if #vim.api.nvim_get_autocmds({ group = group, buffer = bufnr }) > 0 then
			return
		end
		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
			group = group,
			buffer = bufnr,
			callback = function()
				refresh_diagnostics(client)
			end,
		})
	end,

	-- Client-side commands Roslyn asks the editor to run
	commands = {
		-- Completions that edit more than the word under the cursor (e.g. `override` methods)
		["roslyn.client.completionComplexEdit"] = function(command, ctx)
			local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
			local doc, edit = unpack(command.arguments or {})
			if doc and edit and edit.range and edit.newText then
				vim.lsp.util.apply_workspace_edit({
					changes = { [doc.uri] = { { range = edit.range, newText = edit.newText } } },
				}, client.offset_encoding)
			end
		end,

		-- Grouped code actions, e.g. "Extract method > ..." or "Generate > ..."
		["roslyn.client.nestedCodeAction"] = function(command, ctx)
			local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
			local function handle(action)
				if action.data and not action.edit and not action.command then
					-- Not resolved yet: ask the server for the actual edit first
					client:request("codeAction/resolve", action, function(err, resolved)
						if err then
							return notify_error(err)
						end
						if resolved then
							handle(resolved)
						end
					end, ctx.bufnr)
					return
				end
				local nested = vim.islist(action) and action or action.NestedCodeActions
				if type(nested) ~= "table" or #nested == 0 then
					return apply(client, action)
				end
				if #nested == 1 then
					return handle(nested[1])
				end
				vim.ui.select(nested, {
					prompt = action.title or "Select code action",
					format_item = function(item)
						return item.title or (item.command and item.command.title) or "Unnamed action"
					end,
				}, function(choice)
					if choice then
						handle(choice)
					end
				end)
			end
			local arg = command.arguments and command.arguments[1]
			if type(arg) == "table" then
				handle(arg)
			end
		end,

		-- "Fix all occurrences in document / project / solution"
		["roslyn.client.fixAllCodeAction"] = function(command, ctx)
			local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
			local arg = command.arguments and command.arguments[1]
			if type(arg) ~= "table" or type(arg.FixAllFlavors) ~= "table" then
				return
			end
			vim.ui.select(arg.FixAllFlavors, { prompt = "Fix all in:" }, function(scope)
				if not scope then
					return
				end
				client:request("codeAction/resolveFixAll", {
					title = command.title,
					data = arg,
					scope = scope,
				}, function(err, resolved)
					if err then
						return notify_error(err)
					end
					if resolved then
						apply(client, resolved)
					end
				end, ctx.bufnr)
			end)
		end,
	},

	settings = {
		["csharp|background_analysis"] = {
			-- "openFiles" keeps Roslyn light; "fullSolution" reports errors in every file but is heavy
			dotnet_analyzer_diagnostics_scope = "openFiles",
			dotnet_compiler_diagnostics_scope = "openFiles",
		},
		["csharp|completion"] = {
			dotnet_show_completion_items_from_unimported_namespaces = true, -- adds the `using` for you
			dotnet_show_name_completion_suggestions = true,
		},
		-- Shown with <leader>ih
		["csharp|inlay_hints"] = {
			csharp_enable_inlay_hints_for_implicit_object_creation = true,
			csharp_enable_inlay_hints_for_implicit_variable_types = true,
			csharp_enable_inlay_hints_for_lambda_parameter_types = true,
			csharp_enable_inlay_hints_for_types = true,
			dotnet_enable_inlay_hints_for_parameters = true,
			dotnet_enable_inlay_hints_for_literal_parameters = true,
			dotnet_enable_inlay_hints_for_object_creation_parameters = true,
			dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
			dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
		},
	},
}
