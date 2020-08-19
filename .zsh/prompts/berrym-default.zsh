# Version control info
autoload -Uz vcs_info compinit && compinit

zstyle ':vcs_info:*' enable git hg svn cvs bzr
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats "%{$fg[magenta]%}%c%{$fg[green]%}%u\
%{$fg[magenta]%} [%{$fg[green]%}%b%{$fg[magenta]%}]\
-%{$fg[yellow]%}%s%{$reset_color%}:%{$fg[cyan]%}%r%{$reset_color%}"

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

    if [[ ${vcs_info_msg_0_} ]]; then
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
