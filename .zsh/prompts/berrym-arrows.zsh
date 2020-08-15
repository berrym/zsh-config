source $PROMPTDIR/prompt-funcs.zsh

# Prompt configuration
load_custom_prompt() {
    setopt PROMPT_SUBST       # needed for vcs_info_msg_0_

    PROMPT="%(?.$(directory)%{$fg[cyan]%} ➜.$(directory) %{$fg[red]%} $(return_status) ➜)%{$reset_color%} "

    if [[ -z "$SSH_CLIENT" ]]; then
	prompt_host=""
    else
	prompt_host=%{$fg_bold[white]%}@%{$reset_color$fg[yellow]%}$(hostname -s)
    fi

    if [ ${vcs_info_msg_0_} ]; then
	RPROMPT="$(username magenta)${prompt_host} ${vcs_info_msg_0_}%{$reset_color%}"
    else
	RPROMPT="$(username magenta)${prompt_host} $(current_time)%{$reset_color%}"
    fi
}

# Load vcs info before each prompt
precmd() {
    vcs_info
    load_custom_prompt
}
