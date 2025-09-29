function vi --description "Alias for for vim with bare configuration"
  set -l config_dir (test -n "$XDG_CONFIG_HOME"; and echo $XDG_CONFIG_HOME; or echo $HOME/.config)
  command vi -u $config_dir/vim/.vimrc $argv
end
