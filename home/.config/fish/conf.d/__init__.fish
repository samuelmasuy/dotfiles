#
# __init__: Anything that needs to be first.
#

# Set XDG basedirs.
set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.local/state
set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.cache
set -q XDG_RUNTIME_DIR; or set -Ux XDG_RUNTIME_DIR $TMPDIR

set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux DOTFILES_HOME $HOME/.dotfiles.git/master

# Ensure manpath is set to something so we can add to it.
set -q MANPATH || set -gx MANPATH ''

# Add more man page paths.
for manpath in (path filter $__fish_data_dir/man /usr/local/share/man /usr/share/man)
    set -a MANPATH $manpath
end

# Allow subdirs for functions and completions.
set fish_function_path (path resolve $__fish_config_dir/functions/*/) $fish_function_path
set fish_complete_path (path resolve $__fish_config_dir/completions/*/) $fish_complete_path

# Setup caching.
if not set -q __fish_cache_dir
    if set -q XDG_CACHE_HOME
        set -U __fish_cache_dir $XDG_CACHE_HOME/fish
    else
        set -U __fish_cache_dir $HOME/.cache/fish
    end
end
test -d $__fish_cache_dir; or mkdir -p $__fish_cache_dir

# Remove expired cache files.
find $__fish_cache_dir -name '*.fish' -type f -mmin +1200 -delete

# Add bin directories to path.
set -g prepath (
    path filter \
        $HOME/bin \
        $HOME/bin/git \
        $HOME/.local/bin \
        $HOME/.local/bin/aws \
        $HOME/.local/bin/git-toolbelt \
        /usr/local/sbin \
        /usr/local/bin \
        /usr/bin \
        /bin \
        /usr/sbin \
        /sbin \
        $JAVA_HOME/bin \
        $XDG_DATA_HOME/yarn/bin \
        $XDG_DATA_HOME/npm/bin \
        /opt/homebrew/opt/curl/bin \
        /opt/homebrew/opt/gnu-getopt/bin
)
fish_add_path --prepend --move $prepath

if test -d $__fish_config_dir/work
    for file in $__fish_config_dir/work/*.fish
        source $file
    end
end
