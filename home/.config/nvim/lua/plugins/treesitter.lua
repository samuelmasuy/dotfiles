return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- dependencies = {
    --   {
    --     "nvim-treesitter/nvim-treesitter-textobjects",
    --   },
    -- },
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      local ensure_install = {
        "bash",
        "cmake",
        "csv",
        "dockerfile",
        "fish",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "groovy",
        "hcl",
        "html",
        "http",
        "javascript",
        "jq",
        "json",
        "json5",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      }
      -- convert ensure_install to a list of strings
      require("nvim-treesitter").install(ensure_install)

      local syntax_on = {}
      for _, v in ipairs(ensure_install) do
        syntax_on[v] = true
      end
      syntax_on["gitcommit"] = false

      local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(args)
          local bufnr = args.buf
          local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
          if not ok or not parser then
            return
          end
          pcall(vim.treesitter.start)

          local ft = vim.bo[bufnr].filetype
          -- Enable syntax highlighting on all filetype from ensured list except gitcommit

          if syntax_on[ft] then
            vim.bo[bufnr].syntax = "on"
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/playground",
    event = "VeryLazy",
    enabled = false,
  },
}
