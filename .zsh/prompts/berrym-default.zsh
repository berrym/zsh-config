autoload -Uz vcs_info

# set formats
# %s - vcs
# %b - branchname
# %u - unstagedstr
# %c - stagedstr
# %a - action
# %R - repository path
# %S - path in the repository

zstyle ':vcs_info:*' enable git hg svn cvs bzr
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' unstagedstr "%{$fg[red]%} U"
zstyle ':vcs_info:*' stagedstr "%{$fg[green]%} S"
zstyle ':vcs_info:*' formats \
       "%{$fg[cyan]%}(%{$fg[yellow]%}%s%{$fg[cyan]%})-[%{$fg[yellow]%}%b%u%c%{$fg[cyan]%}]%{$reset_color%}"

load_prompt_theme() {
    PS1="%(?.%{$fg[cyan]%}.%{$fg[red]%})%B$(directory 2)%b%{$reset_color%} %# "
    RPS1="%B$(remote_host) ${vcs_info_msg_0_} $(current_time)%b%{$reset_color%}"
}

autoload -Uz add-zsh-hook

add-zsh-hook precmd vcs_info
add-zsh-hook precmd load_prompt_theme
