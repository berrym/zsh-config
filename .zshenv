# Load tmux
if [[ "$SSH_CLIENT" ]]; then
    if [[ -z "$TMUX" ]]; then
        tmux attach -t default || tmux new -s default
    fi
fi
