return {
  {
    "nvim-lualine/lualine.nvim", -- inspired from evil_lualine: https://gist.github.com/hoob3rt/b200435a765ca18f09f83580a606b878
    dependencies = {
      "AndreM222/copilot-lualine",
      -- 	"navarasu/onedark.nvim",
    },
    config = function()
      local lualine = require("lualine")

      -- https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/colors.lua
      -- local colors = require("onedark.colors")
      local colors = require("kanagawa.colors").setup().palette

      -- local colors = require('gruvbox.colors')
      local theme = "kanagawa"

      local diagnostics = {
        "diagnostics",
        sources = { "nvim_lsp" },
        symbols = { error = " ", warn = " ", info = " " },
        color_error = colors.autumnRed,
        color_warn = colors.autumnYellow,
        -- color_info = colors.cyan,
      }

      -- local empty = {function() return '%=' end}

      local lsp = {
        -- Lsp server name .
        function()
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
        end,
        icon = " ",
        color = { fg = colors.waveAqua1 },
        condition = function()
          return #vim.lsp.get_active_clients() > 0 and vim.fn.winwidth(0) > 40
        end,
      }

      local location = { "location", color = { fg = colors.roninYellow, gui = "bold" } }
      local filename = { "filename", color = { fg = colors.fujiWhite, gui = "bold" } }
      local filetype = {
        "filetype",
        condition = function()
          return vim.fn.winwidth(0) > 50
        end,
      }

      local config = {
        options = {
          theme = theme,
          extensions = { "quickfix", "fzf", "fugitive" },
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_c = { filename, diagnostics },
          lualine_x = {
            { "copilot", show_colors = false },
            lsp,
            filetype,
          },
          lualine_y = {},
          lualine_z = { location },
        },
      }

      lualine.setup(config)
    end,
  },
}
