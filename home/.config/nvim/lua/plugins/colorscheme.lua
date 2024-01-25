return {
  {
    "rebelot/kanagawa.nvim",
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

      local opt = vim.opt
      local cmd = vim.cmd

      opt.background = "dark"
      opt.termguicolors = true

      cmd("highlight ColorColumn ctermbg=magenta")
      vim.fn.matchadd("ColorColumn", "\\%101v", 100)

      -- undercurl
      cmd([[
	       hi SpellBad     gui=undercurl term=undercurl cterm=undercurl
	     ]])
      cmd("colorscheme kanagawa")

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

  {
    "navarasu/onedark.nvim",
    enabled = false,

    config = function()
      local opt = vim.opt
      local cmd = vim.cmd

      opt.background = "dark"
      opt.termguicolors = true

      -- Colorscheme
      -- cmd [[colorscheme material]]
      -- cmd [[colorscheme one-nvim]]
      -- cmd [[colorscheme tokyonight]]
      -- cmd [[colorscheme gruvbox]]

      require("onedark").setup({
        style = "dark",
        diagnostics = {
          undercurl = true, -- use undercurl instead of underline for diagnostics
        },
      })
      require("onedark").load()

      -- Colorize the 100th column if goes over.
      cmd("highlight ColorColumn ctermbg=magenta")
      vim.fn.matchadd("ColorColumn", "\\%101v", 100)

      -- undercurl
      cmd([[
	       hi SpellBad     gui=undercurl term=undercurl cterm=undercurl
	     ]])

      -- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      -- for type, icon in pairs(signs) do
      -- 	local hl = "DiagnosticSign" .. type
      -- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      -- end
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
