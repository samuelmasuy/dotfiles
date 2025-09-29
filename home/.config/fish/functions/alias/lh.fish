function lh --wraps='eza -dl .* --group-directories-first' --description 'alias lh=eza -dl .* --group-directories-first'
  eza -dl .* --group-directories-first $argv
end
