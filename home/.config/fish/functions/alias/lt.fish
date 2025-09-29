function lt --wraps='/bin/ls | say -va' --description 'alias lt=/bin/ls | say -va'
  /bin/ls | say -va $argv
end
