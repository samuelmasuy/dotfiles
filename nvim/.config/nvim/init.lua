-- Author: Samuel Masuy and the (n)vim community.

-- set noro

-- Tip:
-- "ap: put (print) content of macro in register a.
-- "ayy: put back current line in register a (macro).
-- ":cdo s/blink/div/g | update
-- switch to last place edited: ''
-- <C-o> in insert mode is awesome

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

--require("impatient")

-- Rebind <leader> key.
vim.g.mapleader = ","
vim.g.disable_toggle_style = true

require("sam")
