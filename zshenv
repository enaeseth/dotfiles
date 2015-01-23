# Source the file from the zprezto tree.

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshenv" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshenv"
fi

export EDITOR=vim
: which mvim && export EDITOR='mvim -f'
export VISUAL="$EDITOR"

function namedir {
    export "$1=$2"
    hash -d "$1=$2"
}

[ -d "$HOME/dotfiles" ] && namedir dots "$HOME/dotfiles"
[ -d "$HOME/.dots" ] && namedir dots "$HOME/.dots"
[ -d "$HOME/Projects/dotfiles" ] && namedir dots "$HOME/Projects/dotfiles"

[[ -s "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"

[[ -d "$HOME/Library/Caches" ]] && {
    export PIP_DOWNLOAD_CACHE="$HOME/Library/Caches/Python/Pip"
    [[ -d "$PIP_DOWNLOAD_CACHE" ]] || mkdir -p "$PIP_DOWNLOAD_CACHE"
}
