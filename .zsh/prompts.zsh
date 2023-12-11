# prompts.zsh - Prompt utilities
#
# (c) 2023 Michael Berry <trismegustis@gmail.com>

# color username
username() {
    local color
    if [[ $ARGC -ne 1 ]]; then
        color=cyan
    else
        color=$1
    fi
    print - "%{$fg[$color]%}%n"
}

# current directory, optionally $level deep
directory() {
    level=$1
    if [[ $level ]]; then
        print - "%$level~"
    else
        print - "%~"
    fi
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
        print - "${remote} ${vcs_info_msg_0_} $(current_time)%{$reset_color%}"
    else
        print - "${remote} $(current_time)%{$reset_color%}"
    fi
}

set_title() {
    print -Pn  "\e]1; $(basename $PWD) \0"
}
