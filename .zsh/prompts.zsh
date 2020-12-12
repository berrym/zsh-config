# Version control info
autoload -Uz vcs_info compinit && compinit

zstyle ':vcs_info:*' enable git hg svn cvs bzr
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:(git|hg|svn|cvs|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' formats "%{$fg[magenta]%}(%{$fg[green]%}%s%{$fg[magenta]%})%{$fg[magenta]%}%c%{$fg[green]%}%u%{$fg[yellow]%} %b%{$reset_color%}:%{$fg[cyan]%}%r%{$reset_color%}"

# color username
username() {
    color=$1
    print - "%{$fg[$color]%}%n%{$reset_color%}"
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
    if [[ -z "$SSH_CLIENT" ]]; then
        print - ""
    else
        print - "%{$fg_bold[white]%}@%{$reset_color$fg[yellow]%}$(hostname -s)"
    fi
}


vcs_info_wrapper() {
    remote=$(remote_host)

    if [[ ${vcs_info_msg_0_} ]]; then
        print - "$(username magenta)${remote} ${vcs_info_msg_0_} $(current_time)%{$reset_color%}"
    else
        print - "$(username magenta)${remote} $(current_time)%{$reset_color%}"
    fi
}

# Load vcs info before each prompt
precmd() {
    vcs_info
    load_custom_prompt
}
