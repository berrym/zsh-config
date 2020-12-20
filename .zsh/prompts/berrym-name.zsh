load_custom_prompt() {
    PROMPT="%(?.%{$fg[green]%}.%{$fg[red]%})$(username magenta)%{$fg[cyan]%} %B$(directory)%{$reset_color%} %# "
    RPROMPT=$(vcs_info_wrapper)
}
