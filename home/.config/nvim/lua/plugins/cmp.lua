return {
  {
    "iguanacucumber/magazine.nvim",
    name = "nvim-cmp", -- Otherwise highlighting gets messed up
    --* the sources *--
    event = { "BufRead", "BufNewFile", "InsertEnter" },
    dependencies = {
      { "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
      { "iguanacucumber/mag-nvim-lua", name = "cmp-nvim-lua", ft = "lua" },
      { "iguanacucumber/mag-buffer", name = "cmp-buffer" },
      { "iguanacucumber/mag-cmdline", name = "cmp-cmdline" },
      "https://codeberg.org/FelipeLema/cmp-async-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "lukas-reineke/cmp-rg",
      "andersevenrud/cmp-tmux",
      "onsails/lspkind.nvim",
      -- "L3MON4D3/LuaSnip",
      -- "rafamadriz/friendly-snippets",
      -- "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        preselect = cmp.PreselectMode.None,
        -- snippet = {
        --   expand = function(args)
        --     require("luasnip").lsp_expand(args.body)
        --   end,
        -- },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        },

        -- The order of your sources matter (by default). That gives them priority
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lua" }, -- only applies this on lua buffers
          -- { name = "luasnip" },
          { name = "async_path" },
          {
            name = "buffer",
            option = {
              keyword_lenghth = 4,
              get_bufnrs = function()
                local bufs = {}
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                  bufs[vim.api.nvim_win_get_buf(win)] = true
                end
                return vim.tbl_keys(bufs)
              end,
            },
          },
          { name = "rg" },
          { name = "tmux" },
        },

        formatting = {
          fields = { "abbr", "kind", "menu" },
          expandable_indicator = true,
          format = require("lspkind").cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
            mode = "symbol",
          }),
        },

        window = {
          completion = {
            -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            -- scrollbar = true,
            winhighlight = "Normal:CmpMenu,FloatBorder:CmpMenuBorder,Search:None",
          },
          documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "NormalFloat:CmpPmenu,FloatBorder:CmpMenuBorder,Search:None",
            -- scrollbar = true,
          },
        },

        view = {
          entries = {
            name = "custom",
            selection_order = "near_cursor",
            vertical_positioning = "above",
          },
        },
        experimental = {
          ghost_text = false,
        },
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "async_path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
}
