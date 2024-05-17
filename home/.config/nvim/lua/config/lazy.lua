require("lazy").setup("plugins", {
  -- defaults = {
  --   lazy = true,
  -- },
  performance = {
    rtp = {
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        -- "tarPlugin",
        "tohtml",
        "tutor",
        -- "zipPlugin",
      },
    },
  },
  -- dev = { },
  -- install = { colorscheme = { "catppuccin", "habamax" } },
  -- checker = { enabled = true },
  -- rtp = {
  -- 	disabled_plugins = {
  -- 	},
  -- },
})
