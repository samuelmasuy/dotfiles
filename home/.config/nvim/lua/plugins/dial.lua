return {
  {
    "monaqa/dial.nvim", -- Better increment/decrement
    event = "VeryLazy",
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        -- default augends used when no group name is specified
        default = {
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.constant.alias.bool, -- boolean value (true <-> false)
          augend.date.alias["%d/%m/%Y"], -- date (31/01/1999, etc.)
        },
      })
    end,
  },
}
