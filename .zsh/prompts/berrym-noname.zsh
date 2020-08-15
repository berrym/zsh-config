source $PROMPTDIR/prompt-funcs.zsh

# Version control info
autoload -Uz vcs_info compinit && compinit

# Prompt configuration
load_custom_prompt() {
    setopt PROMPT_SUBST       # needed for vcs_info_msg_0_
    # prompt without name
    PROMPT="%(?.%{$fg[cyan]%}.%{$fg[red]%})%B$(directory)%b%{$reset_color%} %% "

    if [[ -z "$SSH_CLIENT" ]]; then
	prompt_host=""
    else
	prompt_host=%{$fg_bold[white]%}@%{$reset_color$fg[yellow]%}$(hostname -s)
    fi

    if [ ${vcs_info_msg_0_} ]; then
	RPROMPT="$(username magenta)${prompt_host} ${vcs_info_msg_0_}"
    else
	RPROMPT="$(username magenta)${prompt_host} $(current_time)"
    fi
}

# Load vcs info before each prompt
precmd() {
    vcs_info
    load_custom_prompt
}
