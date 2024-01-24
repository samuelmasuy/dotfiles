return {

  {
    "tpope/vim-fugitive", -- awesome git
    config = function()
      vim.cmd.delcommand("Gremove") -- Superseded by |:GRemove|.
      vim.cmd.delcommand("Gdelete") -- Superseded by |:GDelete|.
      vim.cmd.delcommand("Gmove") -- Superseded by |:GMove|.
      vim.cmd.delcommand("Grename") -- Superseded by |:GRename|.
      vim.cmd.delcommand("Gbrowse") -- Superseded by |:GBrowse|.
      -- vim.cmd.delcommand("Gdiff") -- Superseded by |:Gdiffsplit|
      -- vim.cmd.delcommand("Gsdiff") -- Superseded by |:Ghdiffsplit|
      -- vim.cmd.delcommand("Gvdiff") -- Superseded by |:Gvdiffsplit| or |:vert| |:Gdiffsplit|.
      -- vim.cmd.delcommand("Gblame") -- Superseded by |:Git_blame|.
      vim.api.nvim_create_user_command("GBlame", "G blame", {})
      -- vim.cmd.delcommand("Gcommit") -- Superseded by |:Git| commit.
      vim.api.nvim_create_user_command("GCommit", "G commit", {})
      -- vim.cmd.delcommand("Gmerge") -- Superseded by |:Git| merge and |:Git_mergetool|.
      -- vim.cmd.delcommand("Gpull") -- Superseded by |:Git| pull.
      vim.api.nvim_create_user_command("GPull", "G pull", {})
      -- vim.cmd.delcommand("Grebase") -- Superseded by |:Git| rebase.
      -- vim.cmd.delcommand("Grevert") -- Superseded by |:Git| revert.
      -- vim.cmd.delcommand("Gpush") -- Superseded by |:Git| push.
      vim.api.nvim_create_user_command("GPush", "G push", {})
      -- vim.cmd.delcommand("Gfetch") -- Superseded by |:Git| fetch.
      -- vim.cmd.delcommand("Glog") -- Superseded by |:Gclog|.
      -- vim.cmd.delcommand("Gstatus") --Superseded by |:Git| (with no arguments).
      -- vim.cmd.delcommand("Gsplit!") -- Superseded by |:Git_--paginate|.
      -- vim.cmd.delcommand("Gvsplit!") -- Superseded by :vert Git --paginate.
      -- vim.cmd.delcommand("Gtabsplit!") -- Superseded by :tab Git --paginate.
      -- vim.cmd.delcommand("Gpedit!") -- Superseded by :Git! --paginate.
    end,
  },
  "tpope/vim-rhubarb", -- Companion of fugitive for integration with Github
  {
    "ThePrimeagen/git-worktree.nvim",
    config = true,
  },
  {
    "lewis6991/gitsigns.nvim",
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
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          -- Actions
          map("n", "<leader>hs", gs.stage_hunk)
          map("n", "<leader>hr", gs.reset_hunk)
          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end)
          map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end)
          map("n", "<leader>hS", gs.stage_buffer)
          map("n", "<leader>hu", gs.undo_stage_hunk)
          map("n", "<leader>hR", gs.reset_buffer)
          map("n", "<leader>hp", gs.preview_hunk)
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end)
          map("n", "<leader>tb", gs.toggle_current_line_blame)
          map("n", "<leader>hd", gs.diffthis)
          map("n", "<leader>hD", function()
            gs.diffthis("~")
          end)
          map("n", "<leader>td", gs.toggle_deleted)

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
      })
    end,
  },
}
