if command -v kubecolor >/dev/null 2>&1
  function kubectl --wraps=kubecolor --description 'alias kubectl=kubecolor'
    command kubecolor $argv
  end
end
