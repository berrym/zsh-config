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

# returns 👾 if there are errors, nothing otherwise
return_status() {
    echo "%(?..👾 %?)"
}

# Version control info
autoload -Uz vcs_info compinit && compinit

zstyle ':vcs_info:*' enable git hg svn cvs bzr
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats "%{$fg[magenta]%}%c%{$fg[green]%}%u\
%{$fg[magenta]%} [%{$fg[green]%}%b%{$fg[magenta]%}]\
-%{$fg[yellow]%}%s%{$reset_color%}:%{$fg[cyan]%}%r%{$reset_color%}"
