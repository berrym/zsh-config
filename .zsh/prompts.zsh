# Version control info
autoload -Uz vcs_info compinit && compinit

zstyle ':vcs_info:*' enable git hg svn cvs bzr
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:(git|hg|svn|cvs|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' formats "%{$fg[magenta]%}(%{$fg[green]%}%s%{$fg[magenta]%}) %{$fg[magenta]%}%c%{$fg[green]%}%u%{$fg[yellow]%} %b%{$reset_color%}:%{$fg[cyan]%}%r%{$reset_color%}"

# color username
username() {
    color=$1
    echo "%{$fg[$color]%}%n%{$reset_color%}"
}

# current directory, two levels deep
directory() {
    echo "%2~"
}

# current time with milliseconds
current_time() {
    echo "%*"
}

# returns 👾 and return code if there are errors, nothing otherwise
return_status() {
    echo "%(?..👾 %?)"
}

# determine remote ssh host
remote_host() {
    if [[ -z "$SSH_CLIENT" ]]; then
	echo ""
    else
	echo "%{$fg_bold[white]%}@%{$reset_color$fg[yellow]%}$(hostname -s)"
    fi
}

vcs_info_wrapper() {
    remote=$(remote_host)

    if [[ ${vcs_info_msg_0_} ]]; then
	echo "$(username magenta)${remote} ${vcs_info_msg_0_} $(current_time)%{$reset_color%}"
    else
	echo "$(username magenta)${remote} $(current_time)%{$reset_color%}"
    fi
}
