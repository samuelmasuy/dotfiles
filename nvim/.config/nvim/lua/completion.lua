-- local has_words_before = function()
--   if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
--     return false
--   end
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

-- local feedkey = function(key, mode)
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
-- end

local cmp = require "cmp"

cmp.setup {
  preselect = cmp.PreselectMode.None,
  mapping = {
    -- ["<C-n>"] = cmp.mapping(function()
    --   if vim.fn.pumvisible() == 1 then
    --     feedkey("<C-n>", "n")
    --   else
    --     cmp.complete()
    --   end
    -- end, { "i", "s" }),

    -- ["<S-Tab>"] = cmp.mapping(function()
    --   if vim.fn.pumvisible() == 1 then
    --     feedkey("<C-p>", "n")
    --   end
    -- end, { "i", "s" }),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<c-y>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ['<C-Space>'] = cmp.mapping.complete(),
    -- These mappings are useless. I already use C-n and C-p correctly.
    -- This simply overrides them and makes them do bad things in other buffers.
    -- ["<C-p>"] = cmp.mapping.select_prev_item(),
    -- ["<C-n>"] = cmp.mapping.select_next_item(),
  },

  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" }, -- only applies this on lua buffers
    { name = "path" },
    { name = "buffer", keyword_lenghth = 4 },
  },

  experimental = {
    native_menu = false
  }
}
