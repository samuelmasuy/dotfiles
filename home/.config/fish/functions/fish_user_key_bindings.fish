function fish_user_key_bindings
  # Unsuspend a job and bring it to the foreground
  bind -M insert \cz 'fg 2>/dev/null; commandline -f repaint'
  bind -M insert \cb 'clear-screen'
end
