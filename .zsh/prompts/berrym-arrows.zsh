# Prompt configuration
load_custom_prompt() {
    setopt PROMPT_SUBST       # needed for vcs_info_msg_0_
    PROMPT="%(?.$(directory)%{$fg[cyan]%} ➜.$(directory) %{$fg[red]%} $(return_status true) ➜) %{$reset_color%} "
    RPROMPT=$(vcs_info_wrapper)
}
