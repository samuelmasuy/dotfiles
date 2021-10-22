-- local nvim_lsp = require('lspconfig')
-- vim.lsp.set_log_level("trace")
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  local filetype = vim.api.nvim_buf_get_option(0, "filetype")
  -- if filetype == "go" then
  --   vim.cmd [[
  --     augroup lsp_buf_format
  --       au! BufWritePre <buffer>
  --       autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting()
  --     augroup END
  --   ]]
  -- end
  if filetype == "helm" then
    LspHide()
  end
end

local lsp_installer = require'nvim-lsp-installer'
local function install_missing_servers()
  local lsps = {
    'bashls',
    'gopls',
    'yamlls',
    'pyright',
    'html',
    'jsonls',
    'vimls',
    'tsserver',
    'terraformls',
    'sumneko_lua',
    'dockerls',
  }

  for _, lsp_name in ipairs(lsps) do
    local ok, lsp_server = lsp_installer.get_server(lsp_name)
    if ok then
      if not lsp_server:is_installed() then
        lsp_installer.install(lsp_name)
      end
    end
  end
end
install_missing_servers()

lsp_installer.on_server_ready(
  function(server)
    local opts = {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      },
      settings = {},
      capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    }

    if server.name == "yamlls" then
      opts.settings = {
        yaml = {
          validate = true,
          -- completion = true,
          schemas = {
            kubernetes =  '/rendered.yaml'
          },
        }
      }

          -- trace = {
          --   server = "verbose"
          -- },
          -- schemaDownload = {  enable = true },
          -- validate = true,
      -- print(vim.inspect(opts))
    end

    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
  end
)

-- local check_function = function(bufnr, _)
--     local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'lsp_enabled')
--     -- No buffer local variable set, so just enable by default
--     if not ok then
--         return true
--     end

--     return result
-- end

-- vim.lsp.handlers["textDocument/publishDiagnostics"] =
--     vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--         underline = check_function,
--         signs = false,
--         update_in_insert = false,
--         virtual_text = check_function
--     })


-- function LspSwap()
--     if vim.b.lsp_enabled == false then
--         LspShow()
--     else
--         LspHide()
--     end
-- end

-- vim.api.nvim_buf_set_keymap(0, 'n', 'yop',
--                                 '<cmd>lua require("lsp-local").LspSwap()<CR>',
--                                 {noremap = true})

function LspHide()
    if #vim.lsp.buf_get_clients() > 0 then
        vim.b.lsp_enable = 1
        vim.lsp.diagnostic.disable()
        print("Diagnostic Disabled.")
    else
        error('Diagnostic not enabled in this buffer.')
    end
end

function LspShow()
    if #vim.lsp.buf_get_clients() > 0 then
        vim.b.lsp_enable = 0
        vim.lsp.diagnostic.enable()
        print('Diagnostic Enabled.')
    else
        error('Diagnostic not enabled in this buffer.')
    end
end

function LspSwap()
    if vim.b.lsp_enable == 0 then
        LspShow()
    else
        LspHide()
    end
end

vim.api.nvim_buf_set_keymap(0, 'n', '<space>d', '<cmd>lua LspSwap()<CR>', {noremap = true})
