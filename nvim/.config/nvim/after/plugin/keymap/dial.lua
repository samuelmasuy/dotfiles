local Remap = require("sam.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

nnoremap("<C-a>", require("dial.map").inc_normal())
nnoremap("<C-x>", require("dial.map").dec_normal())
vnoremap("<C-a>", require("dial.map").inc_visual())
vnoremap("<C-x>", require("dial.map").dec_visual())
vnoremap("g<C-a>", require("dial.map").inc_gvisual())
vnoremap("g<C-x>", require("dial.map").dec_gvisual())
