return {
  "saghen/blink.cmp",
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
    },
    "mgalliou/blink-cmp-tmux",
  },

  version = "1.*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "default" },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      nerd_font_variant = "mono",
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = false } },

    sources = {
      default = { "lsp", "path", "buffer", "tmux" },
      per_filetype = {
        codecompanion = { "codecompanion" },
        lua = { "lazydev", inherit_defaults = true },
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        tmux = {
          module = "blink-cmp-tmux",
          name = "tmux",
        },
      },
    },

    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}
