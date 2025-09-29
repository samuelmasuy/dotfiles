function lf --wraps='eza -lF --color=always | grep -v /' --description 'alias lf=eza -lF --color=always | grep -v /'
  eza -lF --color=always | grep -v / $argv
end
