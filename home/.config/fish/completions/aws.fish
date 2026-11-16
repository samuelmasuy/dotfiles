function __fish_complete_aws
    set -lx COMP_SHELL fish
    set -lx COMP_LINE (commandline -pc)
    aws_completer | string trim -r
end

complete -c aws -f -a '(__fish_complete_aws)'
