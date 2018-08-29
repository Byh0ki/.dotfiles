local ret_status="%(?:%{$fg_bold[green]%}%n@%M:%{$fg_bold[cyan]%}%n@%M)"
PROMPT='${ret_status}%{$reset_color%}:%{$fg_bold[blue]%}%~%{$reset_color%}$ $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%} ^|^w"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
