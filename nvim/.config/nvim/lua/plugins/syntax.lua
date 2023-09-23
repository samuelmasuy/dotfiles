return {
  -- Syntax
  { "ajorgensen/vim-markdown-toc", ft = "markdown" },
  { "modille/groovy.vim", ft = { "groovy", "Jenkinsfile" } },
  { "vim-scripts/haproxy", ft = "haproxy*" },
  "towolf/vim-helm",
  { "chr4/nginx.vim", ft = { "nginx" } },
  "mustache/vim-mustache-handlebars",
  "justinmk/vim-syntax-extra",
  -- express yourself well
  { "rhysd/vim-grammarous", ft = { "text", "markdown" } },
  {
    "ron89/thesaurus_query.vim", -- synonym
    keys = { "<leader>cs" },
  },
  { "chrisbra/unicode.vim", ft = { "text", "markdown" } },
  -- all hashicorp goodies
  {
    -- "hashivim/vim-packer",
    "hashivim/vim-terraform",

    -- "hashivim/vim-vaultproject",
  },

  -- tmux
  "tmux-plugins/vim-tmux", -- tmux.conf
  {
    "christoomey/vim-tmux-navigator",
    event = "BufEnter",
  },
}
