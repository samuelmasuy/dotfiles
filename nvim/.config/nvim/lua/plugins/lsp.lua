return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "folke/neodev.nvim",
        ft = "lua",
      },
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
      { "nvimtools/none-ls.nvim" },
      -- { "jay-babu/mason-null-ls.nvim"},
    },
    config = function()
      require("neodev").setup({})
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()

      local on_attach = function(client, bufnr)
        local filetype = vim.api.nvim_buf_get_option(0, "filetype")
        if client.name == "yamlls" and filetype == "helm" then
          vim.lsp.stop_client(client.id)
        end

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

      lsp_zero.on_attach(on_attach)

      -- Diagnostics
      local nnoremap = require("sam.utilities").nnoremap
      nnoremap("[d", vim.diagnostic.goto_prev, { desc = "Previous [d]iagnostic" })
      nnoremap("]d", vim.diagnostic.goto_next, { desc = "Next [d]iagnostic" })
      nnoremap("gl", vim.diagnostic.open_float, { desc = "Open diagnostic" })
      nnoremap("<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic to location list" })

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      })

      local lspconfig = require("lspconfig")
      if not lspconfig.helm_ls then
        lspconfig.helm_ls = {
          default_config = {
            cmd = { "helm_ls", "serve" },
            filetypes = { "helm" },
            root_dir = function(fname)
              return require("lspconfig.util").root_pattern("Chart.yaml")(fname)
            end,
          },
        }
      end
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
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
        },
        handlers = {
          lsp_zero.default_setup,
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
              filetypes = { "helm" },
              cmd = { "helm_ls", "serve" },
            })
          end,
          yamlls = function()
            lspconfig.yamlls.setup({
              settings = {
                yaml = {
                  -- schemas = { kubernetes = "/*.yaml" },
                  validate = true,
                  completion = true,
                },
              },
            })
          end,
        },
      })

      local null_ls = require("null-ls")
      null_ls.setup({
        debounce = 150,
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
  -- {
  --   "folke/neodev.nvim",
  --   event = "VeryLazy",
  --   ft = "lua",
  --   opts = {},
  -- },
}
