function kln --description 'kubectl with label app.kubernetes.io/instance selector'
    set verb $argv[1]
    set resource $argv[2]
    set label $argv[3]
    set rest $argv[4..-1]
    kubectl $verb $resource -l "app.kubernetes.io/instance=$label" $rest
end
