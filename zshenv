# Source the file from the zprezto tree.

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshenv" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshenv"
fi

export EDITOR=vim
: which mvim && export EDITOR='mvim -f'
export VISUAL="$EDITOR"

namedir() {
    local name="$1"

    for loc in "${@:2}"; do
        [[ -d "$loc" ]] && {
            export "${name}=${loc}"
            hash -d "${name}=${loc}"
            break
        }
    done
}

set-gopath() {
    for loc in "$@"; do
        [[ -d "$loc" ]] && {
            export GOPATH="$loc"
            export PATH="${GOBIN:-${GOPATH}/bin}:$PATH"
            break
        }
    done
}

if [[ -d /usr/local/bin ]]; then
    [[ "$PATH" =~ (^|:)"/usr/local/bin"(:|$) ]] || export PATH="/usr/local/bin:$PATH"
fi

[[ -x /usr/bin/yarn || -x /usr/local/bin/yarn ]] && export PATH="$(yarn global bin):$PATH"

namedir src "$HOME/src" "$HOME/Projects"
namedir dots "$src/dotfiles" "$HOME/dotfiles" "$HOME/.dots"

set-gopath "$src/golang" "$HOME/Code"

[[ -s "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"

[[ -d "$HOME/Library/Caches" ]] && {
    export PIP_DOWNLOAD_CACHE="$HOME/Library/Caches/Python/Pip"
    [[ -d "$PIP_DOWNLOAD_CACHE" ]] || mkdir -p "$PIP_DOWNLOAD_CACHE"
}
