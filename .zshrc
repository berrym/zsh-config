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

# Load custom prompt
if [[ -z "SSH_CONNECTION" ]] || [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    loadCustomPrompt berrym-default
else
    # Load starship prompt
    command -v starship &>/dev/null
    if [[ $? -eq 0 ]]; then
        eval "$(starship init zsh)"
    else
        loadCustomPrompt berrym-default
    fi
fi

# Display bovine wisdom
command -v cowsay &>/dev/null && command -v fortune &>/dev/null
if [[ $? -eq 0 ]]; then
    cowsay `fortune`
fi

# pyenv
command -v pyenv &>/dev/null
if [[ $? -eq 0 ]]; then
    eval "$(pyenv virtualenv-init -)"
fi
