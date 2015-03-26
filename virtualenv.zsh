# Virtualenv support

PROJECT_ROOTS=("$HOME/Projects" /src/external /src)
readonly PROJECT_ROOTS

readonly VIRTUALENV_STORAGE="$HOME/Library/User/Python/Environments"

project_root() {
    for root in $PROJECT_ROOTS; do
        if [[ "$1" =~ ^$root/([^/]+) ]]; then
            echo $MATCH
            return
        fi
    done
}

project_name() {
    local root=$(project_root "$1")
    local prefix_length

    [[ -n "$root" ]] || return

    for possibility in $PROJECT_ROOTS; do
        (( prefix_length = ${#possibility} + 1 ))
        if [[ "$root" =~ ^$possibility/([^/]+) ]]; then
            echo ${MATCH[$(($MBEGIN + $prefix_length)),$MEND]}
            return
        fi
    done
}

venv() {
    local name="$1"
    local python="${PYTHON:-python}"
    local dest

    [[ -n "$name" ]] || name=$(project_name "$(pwd)")
    [[ -n "$name" ]] || { echo 'venv: must specify project name' >&2; return 2 }

    dest="${VIRTUALENV_STORAGE}/${name}"

    [[ -d "$dest" ]] || {
        echo "creating ${python} virtualenv at ${dest}" >&2
        virtualenv \
            --python="$python" \
            --prompt="[$name] " \
            "$dest"
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
    local project=$(project_name "$current")
    local project_path
    local expected_env

    [[ -n "$project" ]] && {
        project_path=$(project_root "$current")
        expected_env="${VIRTUALENV_STORAGE}/${project}"

        [[ -d "$expected_env" ||
           -e "${project_path}/setup.py" ||
           -e "${project_path}/requirements.txt" ]] && venv $project
    }
}

[[ -d "$HOME/Library" ]] && {
    [[ -d "$VIRTUALENV_STORAGE" ]] || mkdir -p "$VIRTUALENV_STORAGE"

    chpwd_functions=(${chpwd_functions[@]} "check_venv")

    check_venv # shells don't always start in $HOME
}
