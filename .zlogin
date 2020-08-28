# Load tmux
if [[ "$SSH_CLIENT" ]]; then
    if command -v tmux &>/dev/null && [[ -z "$TMUX" ]]; then
	tmux attach -t default || tmux new -s default
    fi
fi

# Display bovine wisdom
command -v cowsay &>/dev/null && command -v fortune &>/dev/null
if [[ $? -eq 0 ]]; then
    cowsay `fortune`
fi
