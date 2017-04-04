# Source the file from the zprezto tree.

readonly DOTFILES="$(dirname ${ZDOTDIR-~}/.zshrc(:A))"

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc"
fi

source "${DOTFILES}/virtualenv.zsh"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# added by travis gem
[[ -f "$HOME/.travis/travis.sh" ]] && source "$HOME/.travis/travis.sh"
