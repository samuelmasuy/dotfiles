return {
  {
    "nvim-lualine/lualine.nvim", -- inspired from evil_lualine: https://gist.github.com/hoob3rt/b200435a765ca18f09f83580a606b878
    event = "VeryLazy",
    dependencies = {
      "AndreM222/copilot-lualine",
    },
    config = function()
      local lualine = require("lualine")

      local colors = require("kanagawa.colors").setup().palette

      local theme = "kanagawa"

      -- local empty = {function() return '%=' end}

      local lsp = {
        -- Lsp server name .
        function()
          local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
          local clients = vim.lsp.get_clients()
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
        color = { fg = "#577171", bg = colors.sumiInk5 },
        cond = function()
          return #vim.lsp.get_clients() > 0 and vim.fn.winwidth(0) > 70
        end,
      }

      local filename = { "filename", color = { fg = colors.fujiWhite, gui = "bold" } }
      local copilot = {
        "copilot",
        show_colors = false,
        padding = 2,
        color = { bg = colors.sumiInk4, fg = colors.fujiWhite },
      }

      local codeium = {
        padding = 1,
        color = { bg = colors.sumiInk4, fg = colors.fujiWhite },
        'vim.fn["codeium#GetStatusString"]()',
        fmt = function(_)
          return "{…}" .. vim.fn["codeium#GetStatusString"]()
        end,
      }

      local filetype = {
        "filetype",
        color = { bg = colors.sumiInk5 },
        cond = function()
          return vim.fn.winwidth(0) > 60
        end,
      }
      local location = { "location", color = { fg = "#d3bc84", gui = "bold" } }

      local lualine_x = {
        lsp,
        filetype,
      }
      if require("lazy.core.config").plugins["copilot.lua"] then
        table.insert(lualine_x, 1, copilot)
      end
      if require("lazy.core.config").plugins["codeium.vim"] then
        table.insert(lualine_x, 1, codeium)
      end

      local config = {
        options = {
          theme = theme,
          extensions = { "quickfix", "fzf", "fugitive", "lazy" },
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_c = { filename },
          lualine_x = lualine_x,
          lualine_y = {},
          lualine_z = { location },
        },
      }

      lualine.setup(config)
    end,
  },
}
