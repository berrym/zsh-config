# .zshrc - z shell config file
#
# (c) 2021 Michael Berry <trismegustis@gmail.com>

# Load custom scripts
zsh_scripts=(
    $ZSHDIR/zshopts.zsh  # zsh options
    $ZSHDIR/zshfuncs.zsh # utility functions
    $ZSHDIR/aliases.zsh  # aliases
    $ZSHDIR/prompts.zsh  # prompt functions
    $ZSHDIR/third-party.zsh # third party functions
)

for f in $zsh_scripts; do
    if [[ -r $f ]]; then
        . $f
    fi
done

# Load custom prompt
PROMPT_THEME=$PROMPTDIR/berrym-lambda.zsh
if [[ -r $PROMPT_THEME ]]; then
    . $PROMPT_THEME
fi

# Display bovine wisdom
command -v cowsay &>/dev/null && command -v fortune &>/dev/null
if [[ $? -eq 0 ]]; then
    cowsay `fortune`
fi
