return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = false,
    enabled = true,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
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
        colors = {         -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = { -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus",
        },
        overrides = function(colors)
          return {
            -- Blink highlights
            Pmenu = { fg = colors.theme.ui.shade0, bg = colors.theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = "NONE", bg = colors.theme.ui.bg_p2 },
            BlinkCmpMenu = { fg = colors.palette.autumnYellow },
            BlinkCursorLine = { bg = colors.palette.sumiInk3 },
            BlinkCursorColumn = { bg = colors.palette.waveBlue1 },
            BlinkCursorLineInsert = { bg = colors.palette.autumnYellow },
            BlinkCursorLineVisual = { bg = colors.palette.springBlue },
            BlinkCursorLineReplace = { bg = colors.palette.samuraiRed },
            BlinkCursorColumnInsert = { bg = colors.palette.autumnYellow },
            BlinkCursorColumnVisual = { bg = colors.palette.springBlue },
            BlinkCursorColumnReplace = { bg = colors.palette.samuraiRed },

            -- SnacksDashboard
            SnacksDashboardHeader = { fg = colors.theme.vcs.removed },
            SnacksDashboardFooter = { fg = colors.theme.syn.comment },
            SnacksDashboardDesc = { fg = colors.theme.syn.identifier },
            SnacksDashboardIcon = { fg = colors.theme.ui.special },
            SnacksDashboardKey = { fg = colors.theme.syn.special1 },
            SnacksDashboardSpecial = { fg = colors.theme.syn.comment },
            SnacksDashboardDir = { fg = colors.theme.syn.identifier },
          }
        end,
      })

      vim.opt.background = "dark"
      -- vim.opt.termguicolors = true -- nvim 0.10 autodetects it

      -- vim.cmd.highlight("OverLength ctermbg=magenta")
      -- vim.fn.matchadd("OverLength", "\\%101v", 100)

      -- undercurl
      vim.cmd([[
        hi SpellBad     gui=undercurl term=undercurl cterm=undercurl
      ]])
      vim.cmd.colorscheme("kanagawa")

      vim.diagnostic.config({
        severity_sort = true,
        float = {
          source = true,
          border = "rounded",
        },
      })
    end,
  },
}
