# Source the file from the zprezto tree.

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc"
fi

alias gits="git s" # really common typo

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Virtualenv support

VIRTUALENV_STORAGE="$HOME/Library/User/Python/Environments"

project_root() {
    if [[ "$1" =~ ^/src/external/([^/]+) ]]; then
        echo $MATCH
    elif [[ "$1" =~ ^/src/([^/]+) ]]; then
        echo $MATCH
    fi
}

project_name() {
    local root=$(project_root "$1")

    if [[ "$root" =~ ^/src/external/([^/]+) ]]; then
        echo ${MATCH[$(($MBEGIN + 14)),$MEND]}
    elif [[ "$root" =~ ^/src/([^/]+) ]]; then
        echo ${MATCH[$(($MBEGIN + 5)),$MEND]}
    fi
}

venv() {
    local name="$1"
    local dest

    [[ -n "$name" ]] || name=$(project_name "$(pwd)")
    [[ -n "$name" ]] || { echo 'venv: must specify project name' >&2; return 2 }

    dest="${VIRTUALENV_STORAGE}/${name}"

    [[ -d "$dest" ]] || {
        echo "creating virtualenv at ${dest}" >&2
        virtualenv --prompt="[$name] " "$dest"
    }

    type deactivate >/dev/null && deactivate

    source "${dest}/bin/activate"
}

reset-venv() {
    local venv_path="$VIRTUAL_ENV"

    [[ -n "$venv_path" ]] && {
        deactivate
        rm -fr "$venv_path"
        venv
    }
}

check_venv() {
    local current="$(pwd)"
    local project
    local project_path
    local expected_env

    [[ "$current" =~ ^/src/ ]] && {
        project=$(project_name "$current")
        project_path=$(project_root "$current")
        expected_env="${VIRTUALENV_STORAGE}/${project}"

        [[ -d "$expected_env" ||
           -e "${project_path}/setup.py" ||
           -e "${project_path}/requirements.txt" ]] && venv $project
    }
}

[[ -d "$HOME/Library" ]] && [[ -e /src/.pythonic ]] && {
    [[ -d "$VIRTUALENV_STORAGE" ]] || mkdir -p "$VIRTUALENV_STORAGE"

    chpwd_functions=(${chpwd_functions[@]} "check_venv")

    check_venv # shells don't always start in $HOME
}

# added by travis gem
[[ -f "$HOME/.travis/travis.sh" ]] && source "$HOME/.travis/travis.sh"
