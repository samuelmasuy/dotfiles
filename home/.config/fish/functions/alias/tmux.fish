function tmux --description 'tmux with XDG config'
  set -l config_dir (test -n "$XDG_CONFIG_HOME"; and echo $XDG_CONFIG_HOME; or echo $HOME/.config)
  command tmux -f $config_dir/tmux/tmux.conf $argv
end
