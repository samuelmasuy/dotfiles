return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    config = true,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofmt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        dockerfile = { "hadolint" },
      },
      format_on_save = function(bufnr)
        local disable_filetypes = { "yaml", "json", "html", "sh", "markdown" }
        if vim.tbl_contains(disable_filetypes, vim.bo[bufnr].filetype) then
          return nil
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        dockerfile = { "hadolint" },
        markdown = { "markdownlint" },
        sh = { "shellcheck" },
      }
      local lint_augroup = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "saghen/blink.cmp" },
      { "mason-org/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    },
    config = function()
      local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Global default capabilities
      vim.lsp.config("*", {
        capabilities = lsp_capabilities,
        flags = {
          allow_incremental_sync = true,
          debounce_text_changes = 150,
        },
      })

      -- Server-specific overrides (preserve d8a34f3 intent)
      vim.lsp.config("lua_ls", {
        capabilities = lsp_capabilities,
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
          },
        },
      })

      vim.lsp.config("helm_ls", {
        capabilities = lsp_capabilities,
        settings = {
          ["helm-ls"] = {
            yamlls = {
              path = "yaml-language-server",
            },
          },
        },
      })

      require("mason-tool-installer").setup({
        ensure_installed = {
          -- LSP servers (preserve commented intent from d8a34f3)
          "bashls",
          -- "copilot-language-server",
          "dockerls",
          "gh-actions-language-server",
          "gopls",
          "helm_ls",
          "jsonls",
          "lua_ls",
          "pyright",
          "terraformls",
          "ts_ls",
          "vimls",
          "yamlls",
          -- Formatters / linters (replaces mason-null-ls)
          "stylua",
          "hadolint",
          "prettier",
          "markdownlint",
          -- "markdownlint-cli2",
          "shfmt",
          "goimports",
          "shellcheck",
        },
        auto_update = true,
      })

      require("mason-lspconfig").setup({
        ensure_installed = {},
        automatic_enable = true,
      })

      local disable_lsp_on_attach = function(client, bufnr)
        -- preserve d8a34f3 bufnr fix (was _ with vim.bo.filetype)
        if client.name == "yamlls" and vim.bo[bufnr].filetype == "helm" then
          vim.lsp.stop_client(client.id)
        end
      end

      local remap_on_attach = function(_, bufnr)
        local nmap = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = "LSP: " .. desc })
        end

        nmap("gd", Snacks.picker.lsp_definitions, "[g]oto [d]efinition")
        nmap("gD", Snacks.picker.lsp_declarations, "[g]oto [D]eclaration")
        nmap("grr", Snacks.picker.lsp_references, "[g]oto [r]eferences")
        nmap("gi", Snacks.picker.lsp_implementations, "[g]oto [i]mplementation")
        nmap("gy", Snacks.picker.lsp_type_definitions, "[g]oto t[y]pe definition")
        nmap("<leader>ds", Snacks.picker.lsp_symbols, "[S]earch document [S]ymbols")
        nmap("<leader>ws", Snacks.picker.lsp_workspace_symbols, "[S]earch workspace [S]ymbols")

        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("gss", vim.lsp.buf.signature_help, "[g]oto [s]ignature documentation")

        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        nmap("<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")
        nmap("<leader>ll", vim.lsp.codelens.run, "Code[L]ens")
        nmap("<leader>r", function()
          require("conform").format({ async = true, lsp_fallback = true })
        end, "Fo[r]mat")
      end

      -- Diagnostics (preserve d8a34f3: vim.diagnostic.config not vim.lsp.with)
      local nnoremap = require("sam.utilities").nnoremap
      vim.keymap.del("n", "<C-w>d")
      vim.keymap.del("n", "<C-W><C-D>")
      nnoremap("gl", vim.diagnostic.open_float, { desc = "Open diagnostic" })
      nnoremap("<leader>d", vim.diagnostic.setloclist, { desc = "Diagnostic to location list" })

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end
          -- preserve d8a34f3 per-client inlay hint logic (disable for lua_ls)
          if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(client.name ~= "lua_ls", { bufnr = args.buf })
          end
          disable_lsp_on_attach(client, args.buf)
          remap_on_attach(client, args.buf)
        end,
      })
    end,
  },
}
