# Source the file from the zprezto tree.

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile"
fi

export EDITOR=vim
: which mvim && export EDITOR='mvim -f'
export VISUAL="$EDITOR"

alias g='git'

gb() {
  local branches selection branch
  branches=$(git branch --sort=-committerdate -vv) &&
    selection=$(echo "$branches" | fzf --height=20% +m) &&
    branch=$(echo "$selection" | awk '{print $1}' | sed "s/.* //") &&
    if [[ -t 1 ]]; then git checkout "$branch"; else echo $branch; fi
}

gcf() {
  local commits selection commit
  commits=$(git log --pretty=format:'%h [%ad] %s' --date=relative master..HEAD) &&
    selection=$(echo "$commits" | fzf --height=20% +m) &&
    commit=$(echo "$selection" | awk '{print $1}') &&
    if [[ -t 1 ]]; then git commit --fixup "$commit"; else echo $commit; fi
}

alias ga='git add'
alias gam='git amend'
alias gau='git add --update'
alias gap='git add --patch'
alias gc='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gcr='git crush'
alias gcrm='git crush master'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log'
alias glm='git lm'
alias glu='git lu'
alias gn='git new'
alias gp='git pull --rebase --no-tags'
alias gpr='git pull-request'
alias gs='git status'
alias gsh='git show'
alias gr='git roost'
alias grc='git add --update && git rebase --continue'
alias gre='git reset'
alias gre1='git reset HEAD~'
alias gu='git push'
alias gus='git shove'

alias ship='git shove && git pull-request'
