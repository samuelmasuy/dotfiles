return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "folke/neodev.nvim",                ft = "lua", config = true },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "jose-elias-alvarez/null-ls.nvim" },
      -- 'nvim-lua/lsp_extensions.nvim',
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local nnoremap = require("sam.keymap").nnoremap

      local on_attach = function(_, bufnr)
        local function buf_set_option(...)
          vim.api.nvim_buf_set_option(bufnr, ...)
        end

        local nmap = function(rhs, lhs, desc)
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
        nmap("gs", vim.lsp.buf.signature_help, "[g]oto [s]ignature documentation")
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
        nmap("<leader>ll", vim.lsp.codelens.run, "Code[L]ens")

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

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      })

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
        "yamlls",
        "lua_ls",
      }

      -- Ensure the servers above are installed
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = servers,
      })

      local function config(_config)
        return vim.tbl_deep_extend("force", {
          on_attach = on_attach,
          capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
          flags = {
            allow_incremental_sync = true,
            debounce_text_changes = 150,
          },
        }, _config or {})
      end

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

      lspconfig.lua_ls.setup(config({
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
        on_attach = on_attach,
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
    end,
  },
}
