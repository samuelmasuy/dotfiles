function upgrade-neovim-nightly --wraps='mise uninstall neovim@nightly && mise install neovim@nightly' --description 'alias upgrade-neovim-nightly=mise uninstall neovim@nightly && mise install neovim@nightly'
  mise uninstall neovim@nightly && mise install neovim@nightly $argv
end
