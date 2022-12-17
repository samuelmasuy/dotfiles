local nnoremap = require("sam.keymap").nnoremap

local M = {}

-- Diagnostic keymaps
nnoremap("[d", vim.diagnostic.goto_prev)
nnoremap("]d", vim.diagnostic.goto_next)
nnoremap("gl", vim.diagnostic.open_float)
nnoremap("<leader>q", vim.diagnostic.setloclist)

function M.on_attach(_, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	local function nmap(rhs, lhs, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		nnoremap(rhs, lhs, { silent = true, buffer = true, desc = desc })
	end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	nmap("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
	nmap("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[g]oto [r]eferences")
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("gs", vim.lsp.buf.signature_help, "[s]ignature documentation")
	nmap("gi", vim.lsp.buf.implementation, "[g]oto [i]mplementation")
	nmap("<leader>d", vim.lsp.buf.type_definition, "Type [d]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")
	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		if vim.lsp.buf.format then
			vim.lsp.buf.format()
		elseif vim.lsp.buf.formatting then
			vim.lsp.buf.formatting()
		end
	end, { desc = "Format current buffer with LSP" })
	nmap("<leader>r", ":Format<CR>", "Fo[r]mat")

	local filetype = vim.api.nvim_buf_get_option(0, "filetype")
	if filetype == "helm" then
		vim.b.lsp_shown = 0
		vim.diagnostic.disable()
	end
end

require("mason").setup()

-- Enable the following language servers
local servers = {
	"gopls",
	"pyright",
	"html",
	"vimls",
	"tsserver",
	"terraformls",
	"dockerls",
	"bashls",
	"jsonls",
	"sumneko_lua",
}

-- Ensure the servers above are installed
require("mason-lspconfig").setup({
	ensure_installed = servers,
})

local function config(_config)
	return vim.tbl_deep_extend("force", {
		on_attach = M.on_attach,
		capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
		flags = {
			debounce_text_changes = 150,
		},
	}, _config or {})
end

require("lspconfig").gopls.setup(config())
require("lspconfig").pyright.setup(config())
require("lspconfig").html.setup(config())
require("lspconfig").vimls.setup(config())
require("lspconfig").tsserver.setup(config())
require("lspconfig").terraformls.setup(config())
require("lspconfig").dockerls.setup(config())
require("lspconfig").bashls.setup(config())
require("lspconfig").jsonls.setup(config())

require("lspconfig").yamlls.setup(config({
	settings = {
		yaml = {
			-- schemas = { kubernetes = "/*.yaml" },
			validate = true,
			completion = true,
		},
	},
}))

require("lspconfig").sumneko_lua.setup(config({
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

-- Turn on lsp status information
-- require("fidget").setup()
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
