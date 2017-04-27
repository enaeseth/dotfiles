# Source the file from the zprezto tree.

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile"
fi

export EDITOR=vim
: which mvim && export EDITOR='mvim -f'
export VISUAL="$EDITOR"
