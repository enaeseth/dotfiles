# Source the file from the zprezto tree.

readonly DOTFILES="$(dirname ${ZDOTDIR-~}/.zshrc(:A))"

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc"
fi


if [[ -x /Applications/MacVim.app/Contents/MacOS/Vim ]]; then
    export VIM='/Applications/MacVim.app/Contents/MacOS/Vim'
else
    export VIM="$(which vim)"
fi

alias gits="git s" # really common typo
alias vim="$VIM"

source "${DOTFILES}/virtualenv.zsh"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# added by travis gem
[[ -f "$HOME/.travis/travis.sh" ]] && source "$HOME/.travis/travis.sh"
