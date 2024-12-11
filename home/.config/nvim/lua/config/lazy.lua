-- Setup lazy.nvim
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
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "kanagawa", "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
  -- dev = { },
})
