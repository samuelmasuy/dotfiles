function ll --wraps='eza -la --no-permissions --no-user --git-ignore --git --sort modified --icons always' --description 'alias ll=eza -la --no-permissions --no-user --git-ignore --git --sort modified --icons always'
  command eza -la --no-permissions --no-user --git-ignore --git --sort modified --icons always $argv
end
