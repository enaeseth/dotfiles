if [ "$(whoami)" = "root" ]; then NCOLOR="red"; else NCOLOR="white"; fi

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    # hg root >/dev/null 2>/dev/null && echo '☿' && return
    [ -d .svn ] >/dev/null 2>/dev/null && echo '§' && return
    # echo '○'
    echo '➜'
}

function svn_prompt_info {
    [ ! -d .svn ] >/dev/null 2>/dev/null && return
    rev=$(svn info | grep "Changed Rev" | egrep -o "[[:digit:]]+" -)
    suffix="%{$fg_bold[green]%}✔"
    [ -n "$(svn status)" ] && suffix="%{$fg_bold[red]%}✗"
    
    echo "%{$fg_no_bold[yellow]%}$rev$suffix %{$reset_color%}"
}

function battery_charge {
    echo `$BAT_CHARGE` 2>/dev/null
}

PROMPT='%{$fg[magenta]%}%~%{$reset_color%} $(git_prompt_info)$(svn_prompt_info)$(prompt_char)%{$reset_color%} '
RPROMPT='%*'

# PROMPT='%{$fg[$NCOLOR]%}%B%n%b%{$reset_color%}:%{$fg[blue]%}%B%c/%b%{$reset_color%} $(git_prompt_info)%(!.#.$) '
# RPROMPT='$(battery_charge)'

PS2="%_☇ "

# git theming
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_no_bold[yellow]%}%B"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}✗"

# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="exgxBxdxcxegaxabagacad"
export LS_COLORS='di=34;40:ln=36;40:so=1;;40:pi=33;40:ex=32;40:bd=34;46:cd=0;40:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
