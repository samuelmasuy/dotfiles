local copilot_maps = {
  accept = "<Tab>",
  next = "<C-f>",
  prev = "<C-b>",
  dismiss = "<C-]>",
}

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    -- enabled = function()
    --   return vim.fn.isdirectory(vim.fn.expand("$WORKPATH")) ~= 0
    -- end,
    config = function()
      require("copilot").setup({
        filetypes = {
          ["*"] = true,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept_word = false,
            accept_line = false,
            accept = copilot_maps.accept,
            next = copilot_maps.next,
            prev = copilot_maps.prev,
            dismiss = copilot_maps.dissmiss,
          },
        },
        workspace_folders = {
          vim.fn.expand("$WORKPATH/.."),
          vim.fn.expand("$WORKPATH_ALT/.."),
        },
      })
      local copilot_on = true
      vim.api.nvim_create_user_command("CopilotToggle", function()
        if copilot_on then
          vim.cmd("Copilot disable")
          print("Copilot OFF")
        else
          vim.cmd("Copilot enable")
          print("Copilot ON")
        end
        copilot_on = not copilot_on
      end, { nargs = 0 })
    end,
  },
}
