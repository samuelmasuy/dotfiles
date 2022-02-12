# Change cd to do a ls right after executing.
function chpwd() {
    emulate -L zsh
    ls
}
# Display ip adress.
function my_ip() {
    ifconfig | grep 'broadcast' | awk '{print $6}'
}
# Display latest files commited.
function latest() {
    ls -t $1/* | head -n 1
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
# Higlight the matching pattern in a file.
function highlight () {
    grep --color -E "$1|$" "$@"
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

function kube-switch() {
  local version=$(asdf list kubectl | fzf)
  asdf global kubectl $(echo $version | awk '{$1=$1};1')
}

function e() {
  vim $(which $1)
}

zsh_kubectl_minor_version() {
  local kubectl_minor_version=$(kubectl version --client --output=json | jq -r .clientVersion.minor)
  echo -n "($kubectl_minor_version)"
}

src() {
	local cache="$ZSH_CACHE_DIR"
	autoload -U compinit zrecompile
	compinit -i -d "$cache/zcomp-$HOST"

	for f in ${ZDOTDIR:-~}/.zshrc "$cache/zcomp-$HOST"; do
		zrecompile -p $f && command rm -f $f.zwc.old
	done

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
