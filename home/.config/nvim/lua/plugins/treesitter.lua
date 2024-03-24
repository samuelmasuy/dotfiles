return {
  -- TREE SITTER:
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    -- event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
    },
    build = ":TSUpdate",

    -- [[ Config ]]
    -- See `:help nvim-treesitter`
    config = function()
      -- [[ Configure Treesitter ]]
      -- See `:help nvim-treesitter`
      require("nvim-treesitter.configs").setup({
        modules = {},
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = {
          "bash",
          "cmake",
          "csv",
          "dockerfile",
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
          "toml",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        ignore_install = {},
        auto_install = true,
        sync_install = false,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = { "gitcommit", "groovy" },
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]c"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]C"] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[C"] = "@class.outer",
            },
          },
          swap = {
            enable = false,
            -- swap_next = {
            --   ["<leader>p"] = "@parameter.inner",
            -- },
            -- swap_previous = {
            --   ["<leader>P"] = "@parameter.inner",
            -- },
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/playground",
    event = "VeryLazy",
  },
}
