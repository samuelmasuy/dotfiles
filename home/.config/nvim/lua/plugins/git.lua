return {
  {
    "tpope/vim-fugitive", -- awesome git
    event = "VeryLazy",
    dependencies = { "tpope/vim-rhubarb", cmd = "Gbrowse" },
    config = function()
      vim.cmd.delcommand("Gremove") -- Superseded by |:GRemove|.
      vim.cmd.delcommand("Gdelete") -- Superseded by |:GDelete|.
      vim.cmd.delcommand("Gmove") -- Superseded by |:GMove|.
      vim.cmd.delcommand("Grename") -- Superseded by |:GRename|.
      vim.cmd.delcommand("Gbrowse") -- Superseded by |:GBrowse|.
      vim.api.nvim_create_user_command("GBlame", "G blame", {})
    end,
    keys = {
      {
        "<leader>g",
        function()
          vim.cmd.Git()
        end,
        desc = "[g]it",
      },
      {
        "<leader>gp",
        function()
          vim.cmd.Git("push")
        end,
        desc = "[g]it [p]ush",
      },
      {
        "<leader>gl",
        function()
          vim.cmd.Git("pull")
        end,
        desc = "[g]it pul[l]",
      },
      {
        "<leader>gc",
        function()
          vim.cmd.Git("commit")
        end,
        desc = "[g]it [c]ommit",
      },
    },
  },
  {
    "ThePrimeagen/git-worktree.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]h", function()
            if vim.wo.diff then
              return "]h"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Next hunk" })

          map("n", "[h", function()
            if vim.wo.diff then
              return "[h"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Previous hunk" })

          -- Actions
          map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
          map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Stage hunk" })
          map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Reset hunk" })
          map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
          map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
          map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, { desc = "Blame line" })
          map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle blame line" })
          map("n", "<leader>hd", gs.diffthis, { desc = "Diff this against index" })
          map("n", "<leader>hD", function()
            gs.diffthis("~")
          end, { desc = "Diff this against ancestor" })
          map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })

          -- Text object
          -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
      })
    end,
  },
}
