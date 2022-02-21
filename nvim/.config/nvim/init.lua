-- Author: Samuel Masuy and the (n)vim community.

-- set noro

-- Tip:
-- "ap: put (print) content of macro in register a.
-- "ayy: put back current line in register a (macro).
-- ":cdo s/blink/div/g | update
-- switch to last place edited: ''
-- <C-o> in insert mode is awesome

if require 'sam.first_load'() then
  return
end

-- Rebind <leader> key.
vim.g.mapleader = ','
vim.g.disable_toggle_style = true

require('sam')
