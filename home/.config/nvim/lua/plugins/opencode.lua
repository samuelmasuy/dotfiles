return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = { "folke/snacks.nvim" },
    ---@type opencode.Config
    opts = {
      auto_fallback_to_embedded = false,
    },
    -- stylua: ignore
    keys = {
      {
        '<leader>oa',
        function() require('opencode').ask() end,
        desc = 'Ask opencode',
        mode = 'n',
      },
      {
        '<leader>oa',
        function() require('opencode').ask('@selection: ') end,
        desc = 'Ask opencode about selection',
        mode = 'v',
      },
      {
        '<leader>op',
        function() require('opencode').select_prompt() end,
        desc = 'Select prompt',
        mode = { 'n', 'v', },
      },
      {
        '<leader>oy',
        function() require('opencode').command('messages_copy') end,
        desc = 'Copy last message',
      },
      {
        '<leader>of',
        function() require('opencode').prompt('Fix these @diagnostics') end,
        desc = 'Fix diagnostics',
      }
      -- { '<leader>on', function() require('opencode').command('session_new') end,             desc = 'New session', },
      -- { '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end,   desc = 'Scroll messages up', },
      -- { '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end, desc = 'Scroll messages down', },
    },
  },
}
