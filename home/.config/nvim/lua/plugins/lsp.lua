return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile", "BufEnter" },
    dependencies = {
      {
        "folke/neodev.nvim",
        ft = { "lua", "vim" },
      },
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
      { "nvimtools/none-ls.nvim" },
      { "jay-babu/mason-null-ls.nvim" },
    },
    config = function()
      require("neodev").setup({})

      local disable_lsp_on_attach = function(client, bufnr)
        -- vim.notify(client.name .. " lsp client on ft: " .. vim.bo.filetype)
        if client.name == "yamlls" and vim.bo.filetype == "helm" then
          vim.lsp.stop_client(client.id)
        end
      end

      local keys_on_attach = function(client, bufnr)
        local nmap = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = "LSP: " .. desc })
        end

        nmap("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
        nmap("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
        nmap("gr", require("telescope.builtin").lsp_references, "[g]oto [r]eferences")
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("gs", vim.lsp.buf.signature_help, "[g]oto [s]ignature documentation")
        nmap("gi", require("telescope.builtin").lsp_implementations, "[g]oto [i]mplementation")
        nmap("go", vim.lsp.buf.type_definition, "Type [d]efinition")
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
        nmap("<leader>r", function()
          vim.lsp.buf.format({ async = true })
        end, "Fo[r]mat")
      end

      local lsp_formatting = function(bufnr)
        vim.lsp.buf.format({
          filter = function(client)
            return client.name == "null-ls"
          end,
          bufnr = bufnr,
        })
      end

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local format_on_attach = function(client, bufnr)
        if vim.bo.filetype == "yaml" then
          return
        end
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              lsp_formatting(bufnr)
            end,
          })
        end
      end

      local on_attach = function(client, bufnr)
        disable_lsp_on_attach(client, bufnr)
        keys_on_attach(client, bufnr)
        format_on_attach(client, bufnr)
      end

      -- Diagnostics
      local nnoremap = require("sam.utilities").nnoremap
      nnoremap("[d", vim.diagnostic.goto_prev, { desc = "Previous [d]iagnostic" })
      nnoremap("]d", vim.diagnostic.goto_next, { desc = "Next [d]iagnostic" })
      nnoremap("gl", vim.diagnostic.open_float, { desc = "Open diagnostic" })
      nnoremap("<leader>d", vim.diagnostic.setloclist, { desc = "Diagnostic to location list" })

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      })

      local lspconfig = require("lspconfig")
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

      local default_setup = function(server)
        require("lspconfig")[server].setup({
          capabilities = lsp_capabilities,
          on_attach = on_attach,
          flags = {
            allow_incremental_sync = true,
            debounce_text_changes = 150,
          },
        })
      end

      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          "bashls",
          "dockerls",
          "gopls",
          "helm_ls",
          "html",
          "jsonls",
          "lua_ls",
          "pyright",
          "terraformls",
          "tsserver",
          "vimls",
          "yamlls",
        },
        handlers = {
          default_setup,
          lua_ls = function()
            lspconfig.lua_ls.setup({
              settings = {
                Lua = {
                  workspace = {
                    checkThirdParty = false,
                  },
                  -- completion = {
                  --   callSnippet = "Replace",
                  -- },
                },
              },
            })
          end,
          helm_ls = function()
            lspconfig.helm_ls.setup({
              settings = {
                ["helm-ls"] = {
                  yamlls = {
                    path = "yaml-language-server",
                  },
                },
              },
            })
          end,
        },
      })

      require("mason-null-ls").setup({
        ensure_installed = {
          "stylua",
          "hadolint",
          "prettier",
          "markdownlint",
          "shfmt",
          "goimports",
        },
        automatic_installation = false,
        handlers = {},
      })
      local null_ls = require("null-ls")
      null_ls.setup({
        debounce = 150,
        on_attach = on_attach,
        sources = {
          -- null_ls.builtins.formatting.stylua,
          null_ls.builtins.completion.spell,
          -- null_ls.builtins.formatting.prettier,
          -- null_ls.builtins.diagnostics.markdownlint,
          -- null_ls.builtins.formatting.markdownlint,
          -- null_ls.builtins.diagnostics.hadolint,
          -- null_ls.builtins.formatting.shfmt,
          -- null_ls.builtins.formatting.goimports,
          null_ls.builtins.hover.dictionary,

          -- null_ls.builtins.code_actions.refactoring,
          -- null_ls.builtins.diagnostics.checkmake,
        },
      })
    end,
  },
}
