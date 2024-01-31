return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = false,
    enabled = true,
    config = function()
      require("kanagawa").setup({
        compile = true, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = { -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus",
        },
        -- overrides = function(_)
        --   return {
        --     FloatBorder = { bg = "none" },
        --     NormalFloat = { bg = "none" },
        --     FloatTitle = { bg = "none" },
        --   }
        -- end,
      })

      vim.opt.background = "dark"
      vim.opt.termguicolors = true

      vim.cmd.highlight("ColorColumn ctermbg=magenta")
      vim.fn.matchadd("ColorColumn", "\\%101v", 100)

      -- undercurl
      vim.cmd([[
	       hi SpellBad     gui=undercurl term=undercurl cterm=undercurl
	     ]])
      vim.cmd.colorscheme("kanagawa")

      vim.diagnostic.config({
        virtual_text = {
          -- source = "always",  -- Or "if_many"
          -- prefix = "●", -- Could be '■', '▎', 'x'
        },
        severity_sort = true,
        float = {
          source = "always",
          border = "rounded",
          -- source = "always", -- Or "if_many"
        },
      })
    end,
  },
}
