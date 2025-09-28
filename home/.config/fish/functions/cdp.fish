function cpd --description 'Copy files and cd into the directory where the files were copied'
    cp -- $argv[1] $argv[2]; or return
    if test -d $argv[2]
        cd -- $argv[2]
    else
        set dir (dirname $argv[2])
        if test "$dir" != "."
            cd -- $dir
        end
    end
end
