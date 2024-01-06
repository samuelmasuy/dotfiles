return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
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
          accept = "<Tab>",
          accept_word = false,
          accept_line = false,
          next = "<C-f>",
          prev = "<C-b>",
          dismiss = "<C-]>",
        },
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
}
-- return {
--   {
--     "github/copilot.vim",
--     config = function()
--       local copilot_on = true
--       vim.api.nvim_create_user_command("CopilotToggle", function()
--         if copilot_on then
--           vim.cmd("Copilot disable")
--           print("Copilot OFF")
--         else
--           vim.cmd("Copilot enable")
--           print("Copilot ON")
--         end
--         copilot_on = not copilot_on
--       end, { nargs = 0 })
--     end,
--   },
-- }
