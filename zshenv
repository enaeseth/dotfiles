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

namedir TT /src/thumbtack
namedir dev /srv/thumbtack/developers/eric

namedir w "$TT/website"
namedir pub "$w/public"
namedir scripts "$pub/theme/scripts"
namedir styles "$pub/theme/styles"
namedir template "$w/template"

namedir py "$TT/python"
namedir pyt "$py/thumbtack"
namedir flatbed "$pyt/flatbed"
namedir prospect "$pyt/prospect"
namedir tools "$pyt/tools"

namedir kermit "$TT/kermit"
namedir tophat "$TT/tophat"
namedir bowtie "$TT/bowtie"
namedir reports "$TT/reports"
namedir puppet "$TT/puppet"
namedir dashboards "$TT/dashboards"

[ -d "$HOME/bubble/bin" ] && export PATH="$HOME/bubble/bin:$PATH"
