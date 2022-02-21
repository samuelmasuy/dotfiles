require('sam.options')
require('sam.mappings')
require('sam.leader')
require('sam.plugins')
require('sam.colorscheme')
require('sam.line')
require('sam.lsp')
require('sam.completion')

P = function(v)
	print(vim.inspect(v))
	return v
end

if pcall(require, "plenary") then
	RELOAD = require("plenary.reload").reload_module

	R = function(name)
		RELOAD(name)
		return require(name)
	end
end
