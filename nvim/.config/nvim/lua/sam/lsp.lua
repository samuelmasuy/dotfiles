local nnoremap = require("sam.keymap").nnoremap
local lspconfig = require("lspconfig")

local M = {}

function M.on_attach(_, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	local function buf_nmap(rhs, lhs)
		nnoremap(rhs, lhs, { silent = true, buffer = true })
	end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_nmap("gD", vim.lsp.buf.declaration)
	buf_nmap("gd", vim.lsp.buf.definition)
	buf_nmap("K", vim.lsp.buf.hover)
	buf_nmap("gi", vim.lsp.buf.implementation)
	buf_nmap("gs", vim.lsp.buf.signature_help)
	buf_nmap("gr", vim.lsp.buf.references)
	buf_nmap("<leader>wa", vim.lsp.buf.add_workspace_folder)
	buf_nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder)
	buf_nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders))
	end)
	buf_nmap("<leader>d", vim.lsp.buf.type_definition)
	buf_nmap("<leader>rn", vim.lsp.buf.rename)
	buf_nmap("<leader>ca", vim.lsp.buf.code_action)
	buf_nmap("gl", vim.diagnostic.open_float)
	buf_nmap("[d", vim.diagnostic.goto_prev)
	buf_nmap("]d", vim.diagnostic.goto_next)
	buf_nmap("<leader>q", vim.diagnostic.setloclist)
	buf_nmap("<leader>r", vim.lsp.buf.format)

	local filetype = vim.api.nvim_buf_get_option(0, "filetype")
	if filetype == "helm" then
		vim.b.lsp_shown = 0
		vim.diagnostic.disable()
	end
end

local function config(_config)
	return vim.tbl_deep_extend("force", {
		on_attach = M.on_attach,
		capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
		flags = {
			debounce_text_changes = 150,
		},
	}, _config or {})
end

require("nvim-lsp-installer").setup({
	automatic_installation = true,
})

lspconfig.gopls.setup(config())
lspconfig.pyright.setup(config())
lspconfig.html.setup(config())
lspconfig.vimls.setup(config())
lspconfig.tsserver.setup(config())
lspconfig.terraformls.setup(config())
lspconfig.dockerls.setup(config())
lspconfig.bashls.setup(config())
lspconfig.jsonls.setup(config())

lspconfig.yamlls.setup(config({
	settings = {
		yaml = {
			-- schemas = { kubernetes = "/*.yaml" },
			validate = true,
			completion = true,
		},
	},
}))

lspconfig.sumneko_lua.setup(config({
	settings = {
		Lua = {
			-- runtime = {
			--   version = 'LuaJit',
			--   path = vim.split(package.path, ';')
			-- },
			diagnostics = {
				globals = { "vim", "use" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}))

local null_ls = require("null-ls")
null_ls.setup({
	debounce = 150,
	on_attach = M.on_attach,
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.completion.spell,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.diagnostics.markdownlint,
		null_ls.builtins.formatting.markdownlint,
		-- null_ls.builtins.code_actions.refactoring,
		null_ls.builtins.diagnostics.hadolint,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.goimports,
		-- null_ls.builtins.diagnostics.checkmake,
		null_ls.builtins.hover.dictionary,
	},
})

-- local configs = require("lspconfig.configs")
-- local util = require("lspconfig.util")
-- if not configs.helm_ls then
-- 	configs.helm_ls = {
-- 		default_config = {
-- 			cmd = { "helm_ls", "serve" },
-- 			filetypes = { "helm" },
-- 			root_dir = function(fname)
-- 				return util.root_pattern("Chart.yaml")(fname)
-- 			end,
-- 		},
-- 	}
-- end

-- vim.cmd([[ do User LspAttachBuffers ]])

function M.LspHide()
	if #vim.lsp.buf_get_clients() > 0 then
		vim.b.lsp_shown = 0
		vim.diagnostic.hide()
		print("Diagnostic Disabled.")
	else
		error("Diagnostic not enabled in this buffer.")
	end
end

function M.LspShow()
	if #vim.lsp.buf_get_clients() > 0 then
		vim.b.lsp_shown = 1
		vim.diagnostic.show()
		print("Diagnostic Enabled.")
	else
		error("Diagnostic not enabled in this buffer.")
	end
end

function M.LspSwap()
	if vim.b.lsp_shown == 0 then
		M.LspShow()
	else
		M.LspHide()
	end
end

return M
