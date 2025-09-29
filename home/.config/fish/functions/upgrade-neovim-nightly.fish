function upgrade-neovim-nightly --wraps='mise uninstall neovim:neovim@nightly && mise install neovim:neovim@nightly' --description 'alias upgrade-neovim-nightly=mise uninstall neovim:neovim@nightly && mise install neovim:neovim@nightly'
  mise uninstall neovim:neovim@nightly && mise install neovim:neovim@nightly $argv
end
