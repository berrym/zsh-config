# .zshrc - z shell config file
#
# (c) 2023 Michael Berry <trismegustis@gmail.com>

# Load custom scripts
zsh_scripts=(
    $ZSH_DIR/zshopts.zsh     # zsh options
    $ZSH_DIR/miscfuncs.zsh   # utility functions
    $ZSH_DIR/aliases.zsh     # aliases
    $ZSH_DIR/prompts.zsh     # prompt functions
    $ZSH_DIR/third-party.zsh # third party packages
    $ZSH_DIR/completers.zsh  # completion functions
)

for f in $zsh_scripts; do
    [[ -r $f ]] && . $f
done

# Run tmux
if [[ -x "$(command -v tmux)" ]] && [[ -z "$TMUX" ]]; then
    if [[ $SSH_SESSION -gt 0 ]]; then
        spawn_tmux remote new-window
    else
        spawn_tmux local new-window
    fi
fi

# Load custom prompt
if [[ -x "$(command -v starship)" ]]; then
    eval "$(starship init zsh)"
else
    loadPromptTheme berrym-name
fi

# add private ssh key to keychain
add_ssh_key_to_keychain
