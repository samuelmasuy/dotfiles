return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = function()
      -- vim.g doesn't support Lua functions, so we must set them on the config directly.
      -- Derive a unique port per tmux window so each nvim gets its own opencode instance
      -- without conflicting with other opencode processes
      local port
      if vim.env.TMUX then
        local window_id = vim.trim(vim.fn.system("tmux display-message -p '#{window_id}'"))
        -- window_id is like @0, @1, etc. -- extract the number and offset into a safe port range
        local id = tonumber(window_id:match("%d+")) or 0
        port = 7274 + id
      end

      local opts = require("opencode.config").opts
      opts.server = {
        port = port,
        start = function()
          if not vim.env.TMUX then
            vim.notify("Not in a tmux session", vim.log.levels.ERROR, { title = "opencode" })
            return
          end
          local pane_id = vim.trim(
            vim.fn.system(
              string.format("tmux split-window -d -h -P -F '#{pane_id}' 'opencode --port %d'", port)
            )
          )
          vim.fn.system("tmux set-option -t " .. pane_id .. " -p allow-passthrough off")
          vim.g._opencode_tmux_pane_id = pane_id
        end,
        stop = function()
          local pane_id = vim.g._opencode_tmux_pane_id
          if pane_id then
            local pid =
                vim.trim(vim.fn.system("tmux display-message -p -t " .. pane_id .. " '#{pane_pid}'"))
            if pid and pid ~= "" then
              os.execute("kill -TERM -" .. pid .. " 2>/dev/null")
            end
            vim.g._opencode_tmux_pane_id = nil
          end
        end,
        toggle = function()
          local pane_id = vim.g._opencode_tmux_pane_id
          if pane_id then
            local result = vim.fn.system("tmux list-panes -t " .. pane_id)
            if result:match("can't find pane") then
              pane_id = nil
              vim.g._opencode_tmux_pane_id = nil
            end
          end
          if pane_id then
            require("opencode").stop()
          else
            require("opencode").start()
          end
        end,
      }
    end,
    -- stylua: ignore
    keys = {
      {
        '<leader>oa',
        function() require('opencode').ask('@this: ', { submit = true }) end,
        desc = 'Ask opencode',
        mode = { 'n', 'x' },
      },
      {
        '<leader>op',
        function() require('opencode').select() end,
        desc = 'Execute opencode action…',
        mode = { 'n', 'v', },
      },
      {
        '<leader>oy',
        function() require('opencode').command('messages_copy') end,
        desc = 'Copy last message',
      },
      {
        '<leader>of',
        function() require('opencode').prompt('Fix these @diagnostics', { submit = true }) end,
        desc = 'Fix diagnostics',
      },
      -- { '<leader>on', function() require('opencode').command('session_new') end,             desc = 'New session', },
      -- { '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end,   desc = 'Scroll messages up', },
      -- { '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end, desc = 'Scroll messages down', },
    },
  },
}
