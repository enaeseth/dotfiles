# Source the file from the zprezto tree.

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile"
fi

export EDITOR=vim
: which mvim && export EDITOR='mvim -f'
export VISUAL="$EDITOR"

fbr() {
  local branches branch
  branches=$(git branch --sort=-committerdate -vv) &&
    branch=$(echo "$branches" | fzf --height=20% +m) &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
