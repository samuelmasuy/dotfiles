return {
  {
    "mfussenegger/nvim-dap",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
      "leoluz/nvim-dap-go",
      "igorlfs/nvim-dap-view",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")

      require("dap-view").setup()
      require("dap-go").setup()

      require("nvim-dap-virtual-text").setup({
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
            return "*****"
          end

          if #variable.value > 15 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
          end

          return " " .. variable.value
        end,
      })

      vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
      vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

      vim.keymap.set("n", "<space>?", function()
        require("dap-view").add_expr()
      end)

      vim.keymap.set("n", "<space>dc", dap.continue)
      vim.keymap.set("n", "<space>di", dap.step_into)
      vim.keymap.set("n", "<space>do", dap.step_over)
      vim.keymap.set("n", "<space>dt", dap.step_out)
      vim.keymap.set("n", "<space>db", dap.step_back)
      vim.keymap.set("n", "<space>dr", dap.restart)

      -- Close debugger and clear breakpoints
      vim.keymap.set("n", "<localleader>de", function()
        dap.clear_breakpoints()
        dap.terminate()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
        require("notify")("Debugger session ended", "warn")
      end)
    end,
  },
}
