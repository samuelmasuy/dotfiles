# Change cd to do a ls right after executing.
function chpwd() {
    emulate -L zsh
    ls -A
}
# Display ip adress.
function my_ip() {
    ifconfig | grep 'broadcast' | awk '{print $6}'
}

function rgit() {
  find . -type d -name .git -execdir git "$@" \;
}

# Display neatly formatted path of the system.
function path() {
    echo $PATH | tr ":" "\n" | \
        awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
               sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
               sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
               sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
               sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
               print }"
}
# Shell function to define words
# http://vikros.tumblr.com/post/23750050330/cute-little-function-time
function givedef() {
    if [[ $# -ge 2 ]] then
        echo "givedef: too many arguments" >&2
        return 1
    else
        curl "dict://dict.org/d:$1"
    fi
}
# Create a folder and cd into it.
function mcd() {
    mkdir -p "$1" && cd "$1";
}
# Copy files cd into the directory where the files where copied.
function cpd() {
    cp -- "$1" "$2" || return
    if [[ -d "$2" ]]; then
        cd -- "$2"
    else
        case $2 in
              ?*/*) cd -- "${2%/*}" ;;
              /*) cd / ;;
        esac
    fi
}
# Move files cd into the directory where the files where moved.
function mvd() {
    mv -- "$1" "$2" || return
    if [[ -d "$2" ]]; then
        cd -- "$2"
    else
        case $2 in
              ?*/*) cd -- "${2%/*}" ;;
              /*) cd / ;;
        esac
    fi
}

function rawurlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"    # You can either set a return variable (FASTER)
  REPLY="${encoded}"   #+or echo the result (EASIER)... or both... :p
}

function extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
       esac
   else
       echo "'$1' is not a valid file"
   fi
}

function brew-switch() {
  local formulae=$1
  if [ -z "$formulae" ]; then
    echo "no formulae supplied"
    return 1
  fi

  brew_versions=$(brew list --versions $formulae)
  if [ $? -eq 1 ]; then
    echo "could not find formulae: $1"
    return 1
  fi

  local version=$(echo $brew_versions | cut -d' ' -f2- | tr ' ' '\n' | fzf)
  brew switch $formulae $version
}

function e() {
  nvim $(which $1)
}

function git_repo_name() {
  local repo_path
  if repo_path="$(git rev-parse --show-toplevel 2>/dev/null)" && [[ -n "$repo_path" ]]; then
    echo ${repo_path:t}
  fi
}

function git_current_branch() {
  local ref
  ref=$(git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

function ggf() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git push --force-with-lease origin "${b:=$1}"
}

function gpsup() {
  git push --set-upstream origin $(git_current_branch)
}

zsh_kubectl_minor_version() {
  local kubectl_minor_version=$(kubectl version --client --output=json | jq -r .clientVersion.minor)
  echo -n "($kubectl_minor_version)"
}

src() {
	# Use $SHELL if it's available and a zsh shell
	local shell="$ZSH_ARGZERO"
	if [[ "${${SHELL:t}#-}" = zsh ]]; then
		shell="$SHELL"
	fi

	# Remove leading dash if login shell and run accordingly
	if [[ "${shell:0:1}" = "-" ]]; then
		exec -l "${shell#-}"
	else
		exec "$shell"
	fi
}

function kl() {
  local verb="${1}"
  local resource="${2}"
  local labelKeyValue="${3}"
  local rest=("${@:4}")
  kubectl ${verb} ${resource} -l "${labelKeyValue}" ${rest}
}

function kln() {
  local verb="${1}"
  local resource="${2}"
  local label="${3}"
  local rest=("${@:4}")
  kubectl ${verb} ${resource} -l "app.kubernetes.io/instance=${label}" ${rest}
}

function ktime() {
  while read line ; do echo -e "$(gdate +"%Y-%m-%d %H:%M:%S.%3N")\t $line" ; done
}

function kall() {
  local rest=("${@:1}")
  kubectl api-resources --verbs=list --namespaced -o name \
    | xargs -n 1 kubectl get --show-kind --ignore-not-found ${rest}
}

function kgp() {
  kubectl get po --no-headers | fzf | awk '{print $1}'
}

function kd() {
  kgp | xargs -n 1 kubectl describe po
}

function klo() {
  kgp | xargs kubectl logs -f
}

function ko() {
  kgp | xargs kubectl get po -o yaml
}
