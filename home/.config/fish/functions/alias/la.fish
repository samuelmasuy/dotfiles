function la --wraps='eza -la --git --sort modified --icons always' --description 'alias la=eza -la --git --sort modified --icons always'
  command eza -la --git --sort modified --icons always $argv
end
