# oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="eric-remote"
DISABLE_AUTO_UPDATE="true"
plugins=(git ruby github brew pip osx)
source $ZSH/oh-my-zsh.sh

# All hail MacVim
export EDITOR="mvim -f"
export VISUAL="$EDITOR"

# Use color and human-readable filesizes when I ls -l
alias ls="ls -Gh"

# Common gitisms
alias gits="git s" # really common typo
alias grc="git add -u && git rebase --continue"

# Thumbtack path aliases

export PATH="$HOME/bin:/src/thumbtack/python/thumbtack/tools:/src/thumbtack/auto_uploader:$PATH"

export TT=/src/thumbtack
export w=/src/thumbtack/website
export pub=/src/thumbtack/website/public
export scripts=/src/thumbtack/website/public/theme/scripts
export styles=/src/thumbtack/website/public/theme/styles
export template=/src/thumbtack/website/template

export py=/src/thumbtack/python
export flatbed=/src/thumbtack/python/thumbtack/flatbed
export prospect=/src/thumbtack/python/thumbtack/prospect
export reports=/src/thumbtack/reports
export hades=/src/thumbtack/python/thumbtack/hades
export puppet=/src/thumbtack/puppet
export dashboards=/src/thumbtack/dashboards
export tools=/src/thumbtack/python/thumbtack/tools
