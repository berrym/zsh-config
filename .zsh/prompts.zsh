# prompts.zsh - Custom prompts
#
# (c) 2023 Michael Berry <trismegustis@gmail.com>

# Version control info
autoload -Uz vcs_info compinit && compinit

zstyle ':vcs_info:*' enable git hg svn cvs bzr
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:(git|hg|svn|cvs|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' formats "%{$fg[cyan]%}(%{$fg[yellow]%}%s%{$fg[cyan]%})%{$fg[cyan]%}%c%{$fg[yellow]%}%u%{$fg[yellow]%} %b%{$reset_color%}:%{$fg[cyan]%}%r%{$reset_color%}"

# color username
username() {
    color=$1
    print - "%{$fg[$color]%}%n%{$reset_color%}"
}

# current time with milliseconds
current_time() {
    print - "%*"
}

# returns 👾 or another emoji and return code if there are errors, nothing otherwise
return_status() {
    use_emoji=$1
    emoji=$2
    if [[ $use_emoji ]]; then
        if [[ -z $emoji ]]; then
            print - "%(?..👾 %?)"
        else
            print - "%(?..$emoji %?)"
        fi
    else
        print - "%?"
    fi
}

# determine remote ssh host
remote_host() {
    if [[ -z "$SSH_CONNECTION" ]] || [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
        ;
    else
        print - "%{$fg_bold[yellow]%}@%{$reset_color$fg[yellow]%}$(hostname -s)"
    fi
}


vcs_info_wrapper() {
    remote=$(remote_host)

    if [[ ${vcs_info_msg_0_} ]]; then
        print - "$(username cyan)${remote} ${vcs_info_msg_0_} $(current_time)%{$reset_color%}"
    else
        print - "$(username cyan)${remote} $(current_time)%{$reset_color%}"
    fi
}

set_win_title() {
    echo -ne "\033]0; $(basename $PWD) \007"
}

# dummy value for load_custom_prompt
load_custom_prompt() {}

# load vcs info before each prompt
precmd() {
    set_win_title
    vcs_info
    load_custom_prompt
}
