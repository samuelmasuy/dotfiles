local has_words_before = require("sam.utilities").has_words_before

return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      -- "hrsh7th/cmp-nvim-lua", -- for vim.api
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-cmdline",
      "lukas-reineke/cmp-rg",
      "andersevenrud/cmp-tmux",
      "zbirenbaum/copilot-cmp",
      "onsails/lspkind.nvim",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local lsp_zero = require("lsp-zero")
      local cmp = require("cmp")
      local cmp_action = lsp_zero.cmp_action()
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      require("copilot_cmp").setup()

      cmp.setup({
        preselect = cmp.PreselectMode.None,
        completion = {
          keyword_length = 1,
          completeopt = "menu,menuone,noinsert,noselect",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        -- window = {
        --   completion = cmp.config.window.bordered({
        --     winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        --   }),
        --   documentation = cmp.config.window.bordered({
        --     winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        --   }),
        -- },

        formatting = {
          fields = { "abbr", "kind", "menu" },
          expandable_indicator = true,
          format = require("lspkind").cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
            mode = "symbol",
            symbol_map = { Copilot = "" },
          }),
        },
        experimental = {
          ghost_text = true,
        },
        mapping = {
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-k>"] = cmp.mapping.scroll_docs(-4),
          ["<C-j>"] = cmp.mapping.scroll_docs(4),
          ["<C-c>"] = cmp.mapping.abort(),
          ["<C-Space>"] = cmp.mapping({
            i = cmp.mapping.complete(),
            c = function(
              _ --[[fallback]]
            )
              if cmp.visible() then
                if not cmp.confirm({ select = true }) then
                  return
                end
              else
                cmp.complete()
              end
            end,
          }),
          ["<C-f>"] = cmp_action.luasnip_jump_forward(),
          ["<C-b>"] = cmp_action.luasnip_jump_backward(),
        },

        -- The order of your sources matter (by default). That gives them priority
        sources = {
          { name = "copilot" },
          { name = "nvim_lsp" },
          -- { name = "nvim_lua" }, -- only applies this on lua buffers
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip" },
          { name = "path", option = { trailing_slash = true } },
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
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
}
