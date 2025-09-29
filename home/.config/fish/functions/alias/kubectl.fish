if command -v kubecolor >/dev/null 2>&1
  function kubectl --wraps=kubecolor --description 'alias kubectl=kubecolor'
    kubecolor $argv
  end
end
