return {
  {
    "echasnovski/mini.surround",
    version = "*",
    opts = {
      mappings = {
        add = "ys",
        delete = "ds",
        find = "sf",
        find_left = "sF",
        highlight = "sh",
        replace = "cs",
        update_n_lines = "sn",
        suffix_last = "l",
        suffix_next = "n",
      },
    },
    keys = {
      { "ys", desc = "Add surround" },
      { "yss", desc = "Add surround (line)" },
      { "ds", desc = "Delete surround" },
      { "cs", desc = "Change surround" },
      { "S", mode = "v", desc = "Add surround" },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
      -- Keep S as visual add for muscle memory (mini.surround uses ys in visual)
      vim.keymap.set("x", "S", "ys", { remap = true, desc = "Add surround (visual)" })
    end,
  },
}
