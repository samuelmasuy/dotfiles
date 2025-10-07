return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = { "lua", "vim" },
        opts = {},
      },
      { "saghen/blink.cmp" },
      { "mason-org/mason-lspconfig.nvim" },
      { "nvimtools/none-ls.nvim" },
      { "jay-babu/mason-null-ls.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    },
    config = function()
      -- Inlay hints
      vim.lsp.inlay_hint.enable()

      local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()
      local default_setup = function(server)
        vim.lsp.config(server, {
          capabilities = lsp_capabilities,
          flags = {
            allow_incremental_sync = true,
            debounce_text_changes = 150,
          },
        })
      end

      require("mason-tool-installer").setup({
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
          "ts_ls",
          "vimls",
          "yamlls",
        },
        auto_update = true,
      })

      require("mason-lspconfig").setup({
        automatic_installation = true,
        handlers = {
          default_setup,
          lua_ls = function()
            vim.lsp.config("lua_ls", {
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
            vim.lsp.config("helm_ls", {
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
        sources = {
          null_ls.builtins.completion.spell,
          null_ls.builtins.hover.dictionary,
        },
      })

      local disable_lsp_on_attach = function(client, _)
        -- vim.notify(client.name .. " lsp client on ft: " .. vim.bo.filetype)
        if client.name == "yamlls" and vim.bo.filetype == "helm" then
          vim.lsp.stop_client(client.id)
        end
      end

      local remap_on_attach = function(_, bufnr)
        local nmap = function(lhs, rhs, desc)
          vim.keymap.set(
            "n",
            lhs,
            rhs,
            { noremap = true, silent = true, buffer = bufnr, desc = "LSP: " .. desc }
          )
        end

        nmap("gd", Snacks.picker.lsp_definitions, "[g]oto [d]efinition")
        nmap("gD", Snacks.picker.lsp_declarations, "[g]oto [D]eclaration")
        nmap("grr", Snacks.picker.lsp_references, "[g]oto [r]eferences")
        nmap("gi", Snacks.picker.lsp_implementations, "[g]oto [i]mplementation")
        nmap("gy", Snacks.picker.lsp_type_definitions, "[g]oto t[y]pe definition")
        nmap("<leader>ds", Snacks.picker.lsp_symbols, "[S]earch document [S]ymbols")
        nmap("<leader>ws", Snacks.picker.lsp_workspace_symbols, "[S]earch workspace [S]ymbols")

        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("gss", vim.lsp.buf.signature_help, "[g]oto [s]ignature documentation") -- <C-s> in insert mode (neovim 0.11)

        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        nmap("<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")
        nmap("<leader>ll", vim.lsp.codelens.run, "Code[L]ens")
        nmap("<leader>r", function()
          vim.lsp.buf.format({ async = true })
        end, "Fo[r]mat")
      end

      -- Diagnostics
      local nnoremap = require("sam.utilities").nnoremap
      vim.keymap.del("n", "<C-w>d") -- Disable default keymap added in nvim 0.10 to diagnostic.open_float
      vim.keymap.del("n", "<C-W><C-D>")
      nnoremap("gl", vim.diagnostic.open_float, { desc = "Open diagnostic" })
      nnoremap("<leader>d", vim.diagnostic.setloclist, { desc = "Diagnostic to location list" })

      vim.lsp.handlers["textDocument/publishDiagnostics"] =
          vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = false,
          })

      local disable_autoformat_filetypes = {
        "yaml",
        "json",
        "html",
        "sh",
      }
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end
          disable_lsp_on_attach(client, args.buf)
          remap_on_attach(client, args.buf)

          if client:supports_method("textDocument/formatting") then
            if vim.tbl_contains(disable_autoformat_filetypes, vim.bo.filetype) then
              return
            end
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  },
}
