function lf --wraps='eza -lF --color=always | grep -v /' --description 'alias lf=eza -lF --color=always | grep -v /'
  command eza -lF --color=always | grep -v / $argv
end
