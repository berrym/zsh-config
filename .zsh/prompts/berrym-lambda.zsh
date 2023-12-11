autoload -Uz vcs_info

# set formats
# %s - scm
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository

zstyle ':vcs_info:*' enable git hg svn cvs bzr
zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:*:prompt:*' get-revision true
zstyle ':vcs_info:*:prompt:*' unstagedstr '%{$fg[red]%} ●'
zstyle ':vcs_info:*:prompt:*' stagedstr '%{$fg[green]%} ●'
zstyle ':vcs_info:*' formats \
       '%{$fg[cyan]%}(%{$fg[yellow]%}%s%{$fg[cyan]%})-[%{$fg[yellow]%}%b%u%c%{$fg[cyan]%}]%{$reset_color%}'


load_prompt_theme() {
    PS1="%B$(return_status true)%{$fg[magenta]%}$(directory) %{$fg[cyan]%}λ%b%{$reset_colors%} " 
    RPS1="%B$(remote_host) ${vcs_info_msg_0_} $(current_time)%b%{$reset_color%}"
}

autoload -Uz add-zsh-hook

add-zsh-hook precmd set_title
add-zsh-hook precmd vcs_info
add-zsh-hook precmd load_prompt_theme
