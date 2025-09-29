function ls --wraps='/bin/ls -AG' --description 'alias ls=eza -AG'
  eza -AG $argv
end
