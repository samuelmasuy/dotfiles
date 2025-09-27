# Display ip address.
function my_ip
    ifconfig | grep 'broadcast' | awk '{print $6}'
end

# Display neatly formatted path of the system.
function path
    echo $PATH | tr ":" "\n" | \
        awk '{ sub("/usr",   "\033[32m/usr\033[0m"); \
               sub("/bin",   "\033[34m/bin\033[0m"); \
               sub("/opt",   "\033[36m/opt\033[0m"); \
               sub("/sbin",  "\033[35m/sbin\033[0m"); \
               sub("/local", "\033[33m/local\033[0m"); \
               print }'
end

# Create a folder and cd into it.
function mcd
    mkdir -p $argv[1]; and cd $argv[1]
end

# Copy files cd into the directory where the files where copied.
function cpd
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

# Move files cd into the directory where the files where moved.
function mvd
    mv -- $argv[1] $argv[2]; or return
    if test -d $argv[2]
        cd -- $argv[2]
    else
        set dir (dirname $argv[2])
        if test "$dir" != "."
            cd -- $dir
        end
    end
end

function e
    nvim (which $argv[1])
end

function git_repo_name
    set repo_path (git rev-parse --show-toplevel 2>/dev/null)
    if test -n "$repo_path"
        basename $repo_path
    end
end

function git_current_branch
    set ref (git symbolic-ref --quiet HEAD 2>/dev/null)
    if test $status -ne 0
        if test $status -eq 128
            return
        end
        set ref (git rev-parse --short HEAD 2>/dev/null); or return
    end
    echo (string replace 'refs/heads/' '' $ref)
end

function ggf
    if test (count $argv) -ne 1
        set b (git_current_branch)
    else
        set b $argv[1]
    end
    git push --force-with-lease origin $b
end

function gpsup
    git push --set-upstream origin (git_current_branch)
end

function zsh_kubectl_minor_version
    set kubectl_minor_version (kubectl version --client --output=json | jq -r .clientVersion.minor)
    echo -n "($kubectl_minor_version)"
end

function src
    exec $SHELL
end

function kl
    set verb $argv[1]
    set resource $argv[2]
    set labelKeyValue $argv[3]
    set rest $argv[4..-1]
    kubectl $verb $resource -l "$labelKeyValue" $rest
end

function kln
    set verb $argv[1]
    set resource $argv[2]
    set label $argv[3]
    set rest $argv[4..-1]
    kubectl $verb $resource -l "app.kubernetes.io/instance=$label" $rest
end

function ktime
    while read line
        echo -e (gdate +"%Y-%m-%d %H:%M:%S.%3N")"\t $line"
    end
end

function kall
    set rest $argv[1..-1]
    kubectl api-resources --verbs=list --namespaced -o name \
        | xargs -n 1 kubectl get --show-kind --ignore-not-found $rest
end

function kgp
    kubectl get po --no-headers | fzf | awk '{print $1}'
end

function kd
    kgp | xargs -n 1 kubectl describe po
end

function klo
    kgp | xargs kubectl logs -f
end

function ko
    kgp | xargs kubectl get po -o yaml
end
