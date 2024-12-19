return {
  {
    "saghen/blink.cmp",
    version = "v0.*",
    opts = {
      keymap = { preset = "default" },

      completion = {
        list = {
          selection = "auto_insert",
        },
        menu = {
          winhighlight = "Normal:CmpMenu,FloatBorder:CmpMenuBorder,Search:None",
          direction_priority = { "n" },
        },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      sources = {
        default = { "lsp", "path", "buffer" },
      },

      signature = { enabled = true },
    },
  },
}
