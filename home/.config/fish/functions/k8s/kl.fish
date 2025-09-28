function kl --description 'kubectl with label selector'
    set verb $argv[1]
    set resource $argv[2]
    set labelKeyValue $argv[3]
    set rest $argv[4..-1]
    kubectl $verb $resource -l "$labelKeyValue" $rest
end
