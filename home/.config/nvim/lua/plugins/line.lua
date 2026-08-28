return {
  {
    "nvim-lualine/lualine.nvim", -- inspired from evil_lualine: https://gist.github.com/hoob3rt/b200435a765ca18f09f83580a606b878
    event = "BufReadPre",
    dependencies = {
      "AndreM222/copilot-lualine",
    },
    config = function()
      local lualine = require("lualine")

      local colors = require("kanagawa.colors").setup({ theme = "wave" }).palette

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
        cond = function()
          return package.loaded["copilot"] ~= nil
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
      local function is_plugin_enabled(name)
        local spec = require("lazy.core.config").plugins[name]
        if not spec then
          return false
        end
        -- lazy stores evaluated result in spec._.enabled when disabled
        if spec._ and spec._.enabled == false then
          return false
        end
        if type(spec.enabled) == "boolean" then
          return spec.enabled
        end
        if type(spec.enabled) == "function" then
          return spec.enabled() ~= false
        end
        return true
      end
      if is_plugin_enabled("copilot.lua") then
        table.insert(lualine_x, 1, copilot)
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
