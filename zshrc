# Source the file from the zprezto tree.

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc"
fi

alias gits="git s" # really common typo

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Virtualenv support

VIRTUALENV_STORAGE="$HOME/Library/Application Support/Python/Environments"

project_name() {
    [[ "$1" =~ ^/src/([^/]+) ]] && echo ${MATCH[$(($MBEGIN + 5)),$MEND]}
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

check_venv() {
    local current="$(pwd)"
    local project
    local expected_env

    [[ "$current" =~ ^/src/ ]] && {
        project=$(project_name "$current")
        expected_env="${VIRTUALENV_STORAGE}/${project}"

        [[ -d "$expected_env" ]] && venv $project
    }
}

[[ -d "$HOME/Library" ]] && [[ -e /src/.pythonic ]] && {
    [[ -d "$VIRTUALENV_STORAGE" ]] || mkdir -p "$VIRTUALENV_STORAGE"

    chpwd_functions=(${chpwd_functions[@]} "check_venv")
}
