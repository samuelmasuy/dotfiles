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
  {
    -- sudo luarocks install --lua-version 5.1 tiktoken_core
    "CopilotC-Nvim/CopilotChat.nvim", -- depends on copilot.lua and plenary
    branch = "canary",
    -- enabled = function()
    --   return vim.fn.isdirectory(vim.fn.expand("$WORKPATH")) ~= 0
    -- end,
    opts = {
      mode = "split", -- newbuffer or split  , default: newbuffer
      window = {
        layout = "float",
        relative = "cursor",
        width = 1,
        height = 0.6,
        row = 1,
      },
    },
    event = "VeryLazy",
    keys = {
      { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
      { "<leader>ccf", "<cmd>CopilotChatFix<cr>", desc = "CopilotChat - Fix code" },
      { "<leader>ccr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
      { "<leader>ccc", "<cmd>CopilotChatCommit<cr>", desc = "CopilotChat - Commit code" },
      {
        "<leader>ccq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "CopilotChat - Quick chat",
      },
      {
        "<leader>cch",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.help_actions())
        end,
        desc = "CopilotChat - Help actions",
      },
      {
        "<leader>ccp",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "CopilotChat - Prompt actions",
      },
    },
  },
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    enabled = false,
    -- enabled = function()
    --   return vim.fn.isdirectory(vim.fn.expand("$WORKPATH")) == 0
    -- end,
    config = function()
      vim.keymap.set("i", copilot_maps.accept, function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })

      vim.keymap.set("i", copilot_maps.next, function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })

      vim.keymap.set("i", copilot_maps.prev, function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })

      vim.keymap.set("i", copilot_maps.dismiss, function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })
    end,
  },
}
