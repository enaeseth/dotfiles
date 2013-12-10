# Source the file from the zprezto tree.

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc"
fi

alias gits="git s" # really common typo

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
