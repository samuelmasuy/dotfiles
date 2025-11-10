function ks --wraps='kubectl -n kube-system' --description 'alias ks=kubectl -n kube-system'
  command kubectl -n kube-system $argv
end
