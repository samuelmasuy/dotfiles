local M = {}

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
  buf_set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

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
    vim.b.lsp_shown = 0
    vim.diagnostic.disable()
  end
end

local lsp_installer = require'nvim-lsp-installer'
local function install_missing_servers()
  local lsps = {
    'bashls',
    'gopls',
    'yamlls',
    -- 'pyright',
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
      -- local schemas = require("schemastore").json.schemas()

      opts.settings = {
        yaml = {
          validate = true,
          completion = true,
          -- schemas = vim.list_extend(
          --   {
          --     {
          --       kubernetes = '/*.yaml',
          --       name = 'kubernetes',
          --     },
          --   },
          --   require('schemastore').json.schemas()
          -- ),
          schemas = { kubernetes = "/*.yaml" },
          -- schemaStore = {  enable = true, url = "https://json.schemastore.org/schema-catalog.json" },

        }
      }

          -- trace = {
          --   server = "verbose"
          -- },
          -- validate = true,
      -- print(vim.inspect(opts))
    end

    if server.name == "jsonls" then
      opts = {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
          },
        },
        setup = {
          commands = {
            Format = {
              function()
                vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
              end,
            },
          },
        },
      }
    end
    if server.name == "sumneko_lua" then
      opts.settings = {
        Lua = {
          -- runtime = {
          --   version = 'LuaJit',
          --   path = vim.split(package.path, ';')
          -- },
          diagnostics = {
            globals = { 'vim', 'use' }
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false
          },
          telemetry = {
            enable = false
          },
        }
      }
    end

    -- server:setup(require("coq").lsp_ensure_capabilities(opts))
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
  end
)
-- require"fidget".setup{}

function M.LspHide()
    if #vim.lsp.buf_get_clients() > 0 then
        vim.b.lsp_shown = 0
        vim.diagnostic.hide()
        print("Diagnostic Disabled.")
    else
        error('Diagnostic not enabled in this buffer.')
    end
end

function M.LspShow()
    if #vim.lsp.buf_get_clients() > 0 then
        vim.b.lsp_shown = 1
        vim.diagnostic.show()
        print('Diagnostic Enabled.')
    else
        error('Diagnostic not enabled in this buffer.')
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
