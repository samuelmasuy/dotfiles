-- Author: Samuel Masuy and the (n)vim community.

-- set noro

-- Tip:
-- "ap: put (print) content of macro in register a.
-- "ayy: put back current line in register a (macro).
-- ":cdo s/blink/div/g | update
-- switch to last place edited: ''
-- <C-o> in insert mode is awesome

-- Rebind <leader> key.
vim.g.mapleader = ','

if require 'first_load'() then
  return
end

require 'plugins'

require 'options'
require 'mappings'
require 'leader'

require 'lsp'
require 'completion'
