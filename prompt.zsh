function prompt_eric_precmd {
  vcs_info
}

function stgit_prompt_info {
    top=$(stg top 2>/dev/null)
    patches=$(stg series -A 2>/dev/null | wc -l)
    patch_suffix=""

    [ "$patches" -gt 0 ] && (( patches = $patches - 1 ))
    [ "$patches" -gt 0 ] && patch_suffix='%F{038} +'$patches''
    [ -n "$top" ] && echo '%F{032}('"$top$patch_suffix"'%F{032}) %f'
}

function prompt_eric_setup {
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS
  prompt_opts=(cr percent subst)

  # Load required functions.
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  # Add hook for calling vcs_info before each command.
  add-zsh-hook precmd prompt_eric_precmd

  local vcs_format="%b"

  zstyle ':vcs_info:*' enable bzr git hg svn
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:*' actionformats "$vcs_format (%a) "
  zstyle ':vcs_info:*' formats "$vcs_format "
  zstyle ':vcs_info:*' nvcsformats ""

  zstyle ':prezto:module:editor:info:completing' format '%B%F{215}...%f%b'
  zstyle ':prezto:module:editor:info:keymap:primary' format ' %B%F{red}❯%F{yellow}❯%F{green}❯%f%b'
  zstyle ':prezto:module:editor:info:keymap:primary:overwrite' format ' %F{red}♺%f'
  zstyle ':prezto:module:editor:info:keymap:alternate' format ' %B%F{green}❮%F{yellow}❮%F{red}❮%f%b'

  PROMPT='%F{250}%m%f %F{magenta}%~%f %B%F{yellow}${vcs_info_msg_0_%%.}%f%b$(stgit_prompt_info)%B%(?.%F{green}.%F{red})❯❯❯%f%b '
  SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
  PS2="%_☇ "

  export LSCOLORS="exgxBxdxcxegaxabagacad"
  export LS_COLORS='di=34;40:ln=36;40:so=1;;40:pi=33;40:ex=32;40:bd=34;46:cd=0;40:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
}

prompt_eric_setup "$@"
