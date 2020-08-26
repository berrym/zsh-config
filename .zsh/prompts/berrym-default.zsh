# Prompt configuration
load_custom_prompt() {
    setopt PROMPT_SUBST       # needed for vcs_info_msg_0_
    PROMPT="%(?.%{$fg[cyan]%}.%{$fg[red]%})%B$(directory 2)%b%{$reset_color%} %% "
    RPROMPT=$(vcs_info_wrapper)
}
