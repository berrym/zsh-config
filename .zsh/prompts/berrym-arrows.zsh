load_custom_prompt() {
    PROMPT="%(?.%{$fg[cyan]%}√.%{$fg[red]%}$(return_status false))%{$fg[magenta]%} $(directory) %{$fg[yellow]%}➜ "
    RPROMPT=$(vcs_info_wrapper)
}
