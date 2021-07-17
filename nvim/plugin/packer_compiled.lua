-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/samuelmasuy/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/samuelmasuy/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/samuelmasuy/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/samuelmasuy/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/samuelmasuy/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["DirDiff.vim"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/DirDiff.vim"
  },
  ["astronauta.nvim"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/astronauta.nvim"
  },
  ["base16-vim"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/base16-vim"
  },
  ["calvera-dark.nvim"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/calvera-dark.nvim"
  },
  ["dial.nvim"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/dial.nvim"
  },
  fzf = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["gotests-vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/gotests-vim"
  },
  ["groovy.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/groovy.vim"
  },
  haproxy = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/haproxy"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n´\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\foptions\1\0\0\15extensions\1\4\0\0\rquickfix\bfzf\rfugitive\1\0\3\ntheme\fonedark\25component_separators\5\23section_separators\5\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["material.nvim"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/material.nvim"
  },
  ["nlua.nvim"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/nlua.nvim"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-go"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/nvim-go"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\ni\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\14highlight\1\0\0\1\0\1\venable\2\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["one-nvim"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/one-nvim"
  },
  ["onedark.nvim"] = {
    config = { "\27LJ\2\n6\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\vdarker\18onedark_style\6g\bvim\0" },
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/onedark.nvim"
  },
  ["onedark.vim"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/onedark.vim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  tabular = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/tabular"
  },
  ["thesaurus_query.vim"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/thesaurus_query.vim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["typescript-vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/typescript-vim"
  },
  ["unicode.vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/unicode.vim"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-dirvish"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-dirvish"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-grammarous"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-grammarous"
  },
  ["vim-hashicorp-tools"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-hashicorp-tools"
  },
  ["vim-javascript"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-javascript"
  },
  ["vim-json"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-json"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-markdown"
  },
  ["vim-peekaboo"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-peekaboo"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-rooter"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-rooter"
  },
  ["vim-sort-motion"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-sort-motion"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-startuptime"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-syntax-extra"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-syntax-extra"
  },
  ["vim-tmux"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-tmux"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator"
  },
  ["vim-toml"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-toml"
  },
  ["vim-trailing-whitespace"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-trailing-whitespace"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-vinegar"] = {
    loaded = true,
    path = "/Users/samuelmasuy/.local/share/nvim/site/pack/packer/start/vim-vinegar"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: onedark.nvim
time([[Config for onedark.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\vdarker\18onedark_style\6g\bvim\0", "config", "onedark.nvim")
time([[Config for onedark.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n´\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\foptions\1\0\0\15extensions\1\4\0\0\rquickfix\bfzf\rfugitive\1\0\3\ntheme\fonedark\25component_separators\5\23section_separators\5\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\ni\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\14highlight\1\0\0\1\0\1\venable\2\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
if vim.fn.exists(":StartupTime") == 0 then
vim.cmd [[command! -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType json ++once lua require("packer.load")({'vim-json'}, { ft = "json" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'unicode.vim', 'vim-grammarous', 'vim-markdown'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType md ++once lua require("packer.load")({'vim-markdown'}, { ft = "md" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'vim-javascript'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'typescript-vim', 'vim-javascript'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType go ++once lua require("packer.load")({'gotests-vim'}, { ft = "go" }, _G.packer_plugins)]]
vim.cmd [[au FileType text ++once lua require("packer.load")({'unicode.vim', 'vim-grammarous'}, { ft = "text" }, _G.packer_plugins)]]
vim.cmd [[au FileType Jenkinsfile ++once lua require("packer.load")({'groovy.vim'}, { ft = "Jenkinsfile" }, _G.packer_plugins)]]
vim.cmd [[au FileType haproxy* ++once lua require("packer.load")({'haproxy'}, { ft = "haproxy*" }, _G.packer_plugins)]]
vim.cmd [[au FileType *.toml ++once lua require("packer.load")({'vim-toml'}, { ft = "*.toml" }, _G.packer_plugins)]]
vim.cmd [[au FileType groovy ++once lua require("packer.load")({'groovy.vim'}, { ft = "groovy" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/typescript-vim/ftdetect/typescript.vim]], true)
vim.cmd [[source /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/typescript-vim/ftdetect/typescript.vim]]
time([[Sourcing ftdetect script at: /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/typescript-vim/ftdetect/typescript.vim]], false)
time([[Sourcing ftdetect script at: /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/unicode.vim/ftdetect/unicode.vim]], true)
vim.cmd [[source /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/unicode.vim/ftdetect/unicode.vim]]
time([[Sourcing ftdetect script at: /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/unicode.vim/ftdetect/unicode.vim]], false)
time([[Sourcing ftdetect script at: /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/flow.vim]], true)
vim.cmd [[source /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/flow.vim]]
time([[Sourcing ftdetect script at: /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/flow.vim]], false)
time([[Sourcing ftdetect script at: /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/javascript.vim]], true)
vim.cmd [[source /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/javascript.vim]]
time([[Sourcing ftdetect script at: /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/javascript.vim]], false)
time([[Sourcing ftdetect script at: /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-json/ftdetect/json.vim]], true)
vim.cmd [[source /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-json/ftdetect/json.vim]]
time([[Sourcing ftdetect script at: /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-json/ftdetect/json.vim]], false)
time([[Sourcing ftdetect script at: /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], true)
vim.cmd [[source /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], false)
time([[Sourcing ftdetect script at: /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-toml/ftdetect/toml.vim]], true)
vim.cmd [[source /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-toml/ftdetect/toml.vim]]
time([[Sourcing ftdetect script at: /Users/samuelmasuy/.local/share/nvim/site/pack/packer/opt/vim-toml/ftdetect/toml.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
