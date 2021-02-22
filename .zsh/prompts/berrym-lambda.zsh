load_custom_prompt() {
    PROMPT="$(return_status false)%{$fg[magenta]%}$(directory) %{$fg[cyan]%}λ " 
    RPROMPT=$(vcs_info_wrapper)
}

