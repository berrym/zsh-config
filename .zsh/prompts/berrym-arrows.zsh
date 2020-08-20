# Prompt configuration
load_custom_prompt() {
    setopt PROMPT_SUBST       # needed for vcs_info_msg_0_
    PROMPT="%(?.$(directory)%{$fg[cyan]%} ➜.$(directory) %{$fg[red]%} $(return_status) ➜)%{$reset_color%} "
    RPROMPT=$(vcs_info_wrapper)
}

# Load vcs info before each prompt
precmd() {
    vcs_info
    load_custom_prompt
}
