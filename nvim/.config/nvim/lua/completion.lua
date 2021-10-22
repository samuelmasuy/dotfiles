-- local has_words_before = function()
--   if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
--     return false
--   end
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

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
    { name = "buffer" },
    { name = "path" },
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
  },
}

-- require'compe'.setup {
--   enabled = true;
--   autocomplete = true;
--   debug = false;
--   min_length = 1;
--   preselect = 'disable';
--   throttle_time = 80;
--   source_timeout = 200;
--   incomplete_delay = 400;
--   max_abbr_width = 100;
--   max_kind_width = 100;
--   max_menu_width = 100;
--   documentation = true;

--   source = {
--     path = true,
--     buffer = true,
--     calc = true,

--     nvim_lsp = true,
--     nvim_lua = true,

--     -- luasnip = true,
--     treesitter = false,
--     snippets_nvim = false,
--     vsnip = false,

--     emoji = true,
--   };
-- }
-- local t = function(str)
--   return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end

-- local check_back_space = function()
--   local col = vim.fn.col('.') - 1
--   if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
--     return true
--   else
--     return false
--   end
-- end

-- -- Use (s-)tab to:
-- --- move to prev/next item in completion menuone
-- --- jump to prev/next snippet's placeholder
-- _G.tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--     return t "<C-n>"
--   elseif check_back_space() then
--     return t "<Tab>"
--   else
--     return vim.fn['compe#complete']()
--   end
-- end
-- _G.s_tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--     return t "<C-p>"
--   else
--     return t "<S-Tab>"
--   end
-- end

-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
