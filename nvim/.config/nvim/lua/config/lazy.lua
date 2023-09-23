--  bootstrap lazy package manager
--  <https://github.com/folke/lazy.nvim>
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("plugins", {
  -- defaults = {
  -- 	version = "*",
  -- },
  -- dev = { },
  -- install = { colorscheme = { "catppuccin", "habamax" } },
  -- checker = { enabled = true },
  -- rtp = {
  -- 	disabled_plugins = {
  -- 	},
  -- },
})
