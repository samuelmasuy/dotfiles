return {
  {
    "echasnovski/mini.files",
    lazy = false,
    version = false,
    opts = {
      mappings = {
        close = "q",
        go_in = "L",
        -- go_in_plus = "<Enter>",
        go_in_plus = "l",
        go_out = "h",
        go_out_plus = "H",
        reset = "<BS>",
        reveal_cwd = "@",
        show_help = "g?",
        synchronize = "=",
        trim_left = "<",
        trim_right = ">",
      },
      options = {
        -- Whether to delete permanently or move into module-specific trash
        permanent_delete = false,
      },
      -- Customization of explorer windows
      windows = {
        -- Whether to show preview of file/directory under cursor
        preview = false,
      },
    },
    keys = {
      {
        "-",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0))
        end,
        desc = "Open mini.files",
      },
    },
  },
}
