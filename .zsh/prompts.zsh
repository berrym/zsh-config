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
