vim.cmd [[packadd packer.nvim]]
vim.cmd [[packadd vimball]]

vim.cmd [[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]]

return require('packer').startup {
  function(use)
    use 'wbthomason/packer.nvim'

    use {
        'tjdevries/astronauta.nvim', -- Lua ftplugins & lua plugin
        'nvim-lua/plenary.nvim', -- lua utils
    }

    -- Better profiling output for startup.
    use {
      'dstein64/vim-startuptime',
      cmd = 'StartupTime',
    }

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/nvim-compe'

    -- Text Maniuplation
    use 'godlygeek/tabular' -- Quickly align text by pattern :'<,'>Tabularize /:
    use 'tpope/vim-commentary' -- Easily comment out lines or objects
    use 'tpope/vim-repeat' -- Repeat actions better
    use 'tpope/vim-abolish' -- Camel case, snake crc
    use 'tpope/vim-surround' -- To change surrounding quote: cs(' ;tag cst<th> ;to add quote ysW'
    use 'monaqa/dial.nvim' -- Better increment/decrement
    use 'tpope/vim-unimpaired'

    -- GIT
    use 'tpope/vim-fugitive' -- awesome git
    use 'tpope/vim-rhubarb' -- Companion of fugitive for integration with Github

    -- search
    use 'airblade/vim-rooter' -- auto cwd in root git repo
    use '/usr/local/opt/fzf'
    use 'junegunn/fzf.vim'
    use 'junegunn/vim-peekaboo' -- what's in @ and \"
    -- use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' } }

    -- TREE SITTER:
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require'nvim-treesitter.configs'.setup {
          highlight = {
            enable = true,
          },
        }
      end,
      requires = {
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'RRethy/nvim-treesitter-textsubjects',
      },
    }

    -- Syntax
    use 'kyazdani42/nvim-web-devicons'
    use { 'tpope/vim-markdown', ft = { 'markdown', 'md' } }
    use 'ajorgensen/vim-markdown-toc'
    use { 'pangloss/vim-javascript', ft = { 'javascript', 'typescript' } }
    use { 'leafgarland/typescript-vim', ft = 'typescript' }
    use { 'modille/groovy.vim', ft = { 'groovy', 'Jenkinsfile' } }
    use { 'vim-scripts/haproxy', ft = 'haproxy*' }
    use { 'cespare/vim-toml', ft = '*.toml' }
    use 'tjdevries/nlua.nvim'
    use { 'elzr/vim-json', ft = 'json' }
    use 'towolf/vim-helm'
    use 'chr4/nginx.vim'

    -- use 'NLKNguyen/cloudformation-syntax.vim'
    -- use { 'stephpy/vim-yaml', ft = 'yaml' }
    -- use 'mhinz/vim-rfc' -- sudo gem install nokogiri
    -- use { 'vim-scripts/rfc-syntax', ft = 'rfc' }
    use 'justinmk/vim-syntax-extra'

    -- all go
    use {
        'crispgm/nvim-go',
        run = ':GoInstallBinaries',
        requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' }
        -- ft = 'go',
    }
    use { 'buoto/gotests-vim', ft = 'go',  run = ':!go install github.com/cweill/gotests/...' }

    -- express yourself well
    use { 'rhysd/vim-grammarous', ft = { 'text', 'markdown' } }
    use 'ron89/thesaurus_query.vim' -- synonym <leader>cs
    use { 'chrisbra/unicode.vim', ft = { 'text', 'markdown' } }

    -- colorschemes
    use { 'joshdick/onedark.vim' }
    use {
      'navarasu/onedark.nvim',
      config = function()
        vim.g.onedark_style = 'darker'
      end
    }
    use { 'chriskempson/base16-vim' }
    use { 'yashguptaz/calvera-dark.nvim' }
    use { 'marko-cerovac/material.nvim' }
    use { 'Th3Whit3Wolf/one-nvim' }
    use { 'folke/tokyonight.nvim' }

    -- line
    use {
      'hoob3rt/lualine.nvim',
      config = function()
        require('lualine').setup {
          options = {
            theme = 'onedark',
            extensions = {'quickfix', 'fzf', 'fugitive'},
            section_separators = '',
            component_separators = '',
          }
        }
      end
    }

    -- utils
    use 'mhinz/vim-startify' -- Startup Screen

    use 'tpope/vim-vinegar' -- Enhance netrw
    use 'tpope/vim-eunuch' -- Adds Unix commands to vim.
    use 'justinmk/vim-dirvish' -- minimalist directory viewer -
    -- use 'Valloric/MatchTagAlways'
    -- use 'Valloric/ListToggle' -- quick*fix* *l*ocation
    use 'vim-scripts/DirDiff.vim' -- :DirDiff <A:Src Directory> <B:Src Directory>
    use 'bronson/vim-trailing-whitespace' -- show them
    -- use 'vim-scripts/visSum.vim' -- <leader>su
    -- use 'vim-scripts/VisIncr' -- Increment all the things v-select jan\njan\njan :IM.
    -- use 'mbbill/undotree'
    -- use 'machakann/vim-highlightedyank'
    use 'christoomey/vim-sort-motion' -- sort lines characters arguments etc
    -- use 'fmoralesc/vim-tutor-mode'
    -- use 'janko/vim-test' -- let test#strategy = 'neovim'
    use 'christianrondeau/vim-base64' -- <leader>atob / btoa

    -- all hashicorp goodies
    use 'hashivim/vim-hashicorp-tools'

    -- tmux
    use 'tmux-plugins/vim-tmux' -- tmux.conf
    use 'christoomey/vim-tmux-navigator'
  end,

  config = {
    display = {
      -- open_fn = require('packer.util').float,
    },
  },
}
