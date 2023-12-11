autoload -Uz add-zsh-hook vcs_info

zstyle ':vcs_info:*' enable git hg svn cvs bzr
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' formats \
       "%{$fg[cyan]%}(%{$fg[yellow]%}%s%{$fg[cyan]%})" \
       "%{$fg[cyan]%}%c%{$fg[yellow]%}%u%{$fg[yellow]%} %b" \
       "%{$reset_color%}:%{$fg[cyan]%}%r%{$reset_color%}"

load_prompt_theme() {
    PS1="%(?.%{$fg[cyan]%}.%{$fg[red]%})%B$(username '')%{$fg[green]%} $(directory)%b%{$reset_color%} %% "
    RPS1="%B$(vcs_info_wrapper)%b"
}

add-zsh-hook precmd set_title
add-zsh-hook precmd vcs_info
add-zsh-hook precmd load_prompt_theme
