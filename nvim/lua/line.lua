-- local onedark_line = require'lualine.themes.onedark'
local lualine = require 'lualine'
-- https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/colors.lua
local colors = require('onedark.colors')

local diagnostics = {
  'diagnostics',
  sources = {'nvim_lsp'},
  symbols = {error = ' ', warn = ' ', info = ' '},
  color_error = colors.red,
  color_warn = colors.yellow,
  color_info = colors.cyan,
}

-- local empty = {function() return '%=' end}

local lsp = {
  -- Lsp server name .
  function()
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then return end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return
  end,
  icon = ' ',
  color = {fg = colors.dark_cyan},
  condition = function() return #vim.lsp.get_active_clients() > 0 end,
}

local location = {'location', color = {fg = colors.dark_yellow, gui = 'bold'}}
local filename = {'filename', color = {fg = colors.fg, gui = 'bold'}}

local config = {
  options = {
    theme = 'onedark',
    extensions = {'quickfix', 'fzf', 'fugitive'},
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_c = {filename, diagnostics},
    lualine_x = {lsp, 'filetype'},
    lualine_y = {},
    lualine_z = {location}
  },
}

lualine.setup(config)
