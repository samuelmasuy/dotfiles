function ls --wraps='/bin/ls -AG' --description 'alias ls=eza -AG'
  command eza -AG $argv
end
