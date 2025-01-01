return {
  -- "mhinz/vim-startify" -- Startup Screen
  {
    "tpope/vim-eunuch", -- Adds Unix commands to vim.
    event = "VeryLazy",
  },
  -- 'Valloric/MatchTagAlways'
  -- 'Valloric/ListToggle' -- quick*fix* *l*ocation
  {
    "vim-scripts/DirDiff.vim", -- :DirDiff <A:Src Directory> <B:Src Directory>
    cmd = "DirDiff",
  },

  {
    "bronson/vim-trailing-whitespace", -- show them
    event = "VeryLazy",
  },
  -- 'vim-scripts/visSum.vim' -- <leader>su
  -- 'vim-scripts/VisIncr' -- Increment all the things v-select jan\njan\njan :IM.
  -- 'mbbill/undotree'
  -- 'machakann/vim-highlightedyank'
  {
    "christoomey/vim-sort-motion", -- sort lines characters arguments etc
    init = function()
      vim.g.sort_motion = "gso"
      vim.g.sort_motion_lines = "gsos"
      vim.g.sort_motion_visual = "gso"
    end,
    keys = { "gso", "gsos", { "gso", mode = "v" } },
  },
  -- 'fmoralesc/vim-tutor-mode'
  -- 'janko/vim-test' -- let test#strategy = 'neovim'
  {
    "taybart/b64.nvim",
    cmd = { "B64Encode", "B64Decode" },
  },
}
