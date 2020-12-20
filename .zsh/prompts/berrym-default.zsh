load_custom_prompt() {
    PROMPT="%(?.%{$fg[cyan]%}.%{$fg[red]%})%B$(directory 2)%b%{$reset_color%} %% "
    RPROMPT=$(vcs_info_wrapper)
}
