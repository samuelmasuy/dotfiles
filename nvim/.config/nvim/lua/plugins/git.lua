return {

	{
		"tpope/vim-fugitive", -- awesome git
		config = function()
			vim.cmd.delcommand("Gremove") -- Superseded by |:GRemove|.
			vim.cmd.delcommand("Gdelete") -- Superseded by |:GDelete|.
			vim.cmd.delcommand("Gmove") -- Superseded by |:GMove|.
			vim.cmd.delcommand("Grename") -- Superseded by |:GRename|.
			vim.cmd.delcommand("Gbrowse") -- Superseded by |:GBrowse|.
			-- vim.cmd.delcommand("Gdiff") -- Superseded by |:Gdiffsplit|
			-- vim.cmd.delcommand("Gsdiff") -- Superseded by |:Ghdiffsplit|
			-- vim.cmd.delcommand("Gvdiff") -- Superseded by |:Gvdiffsplit| or |:vert| |:Gdiffsplit|.
			-- vim.cmd.delcommand("Gblame") -- Superseded by |:Git_blame|.
			vim.api.nvim_create_user_command("GBlame", "G blame", {})
			-- vim.cmd.delcommand("Gcommit") -- Superseded by |:Git| commit.
			vim.api.nvim_create_user_command("GCommit", "G commit", {})
			-- vim.cmd.delcommand("Gmerge") -- Superseded by |:Git| merge and |:Git_mergetool|.
			-- vim.cmd.delcommand("Gpull") -- Superseded by |:Git| pull.
			vim.api.nvim_create_user_command("GPull", "G pull", {})
			-- vim.cmd.delcommand("Grebase") -- Superseded by |:Git| rebase.
			-- vim.cmd.delcommand("Grevert") -- Superseded by |:Git| revert.
			-- vim.cmd.delcommand("Gpush") -- Superseded by |:Git| push.
			vim.api.nvim_create_user_command("GPush", "G push", {})
			-- vim.cmd.delcommand("Gfetch") -- Superseded by |:Git| fetch.
			-- vim.cmd.delcommand("Glog") -- Superseded by |:Gclog|.
			-- vim.cmd.delcommand("Gstatus") --Superseded by |:Git| (with no arguments).
			-- vim.cmd.delcommand("Gsplit!") -- Superseded by |:Git_--paginate|.
			-- vim.cmd.delcommand("Gvsplit!") -- Superseded by :vert Git --paginate.
			-- vim.cmd.delcommand("Gtabsplit!") -- Superseded by :tab Git --paginate.
			-- vim.cmd.delcommand("Gpedit!") -- Superseded by :Git! --paginate.
		end,
	},
	"tpope/vim-rhubarb", -- Companion of fugitive for integration with Github
}
