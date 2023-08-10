return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua", -- for vim.api
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-cmdline",
			"lukas-reineke/cmp-rg",
			"andersevenrud/cmp-tmux",
			-- "L3MON4D3/LuaSnip",
			-- "rafamadriz/friendly-snippets",
			-- "saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				preselect = cmp.PreselectMode.None,
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = {
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.abort(),
					["<c-y>"] = cmp.mapping(
						cmp.mapping.confirm({
							behavior = cmp.ConfirmBehavior.Insert,
							select = true,
						}),
						{ "i", "c" }
					),
					["<c-space>"] = cmp.mapping({
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
					["<tab>"] = cmp.config.disable,
				},

				-- The order of your sources matter (by default). That gives them priority
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lua" }, -- only applies this on lua buffers
					{ name = "luasnip" },
					{ name = "path" },
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

				experimental = {
					native_menu = false,
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