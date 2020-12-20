# .zshrc - z shell config file
#
# (c) 2020 Michael Berry <trismegustis@gmail.com>

print - "$fg[yellow] * $fg[magenta] Sourcing .zshrc$reset_color"

# Load custom scripts
zsh_scripts=(
    $ZSHDIR/zshopts.zsh  # zsh options
    $ZSHDIR/zshfuncs.zsh # utility functions
    $ZSHDIR/aliases.zsh  # aliases
    $ZSHDIR/prompts.zsh  # prompt functions
    $ZSHDIR/third-party.zsh # third party functions
)

print - "$fg[yellow] * $fg[magenta] Loading custom scripts."
for f in $zsh_scripts; do
    if [[ -r $f ]]; then
        print - "$fg[cyan]    * loading $f"
        . $f
    else
        print - "$fg[red]    Unable to load $f"
    fi
done

# Load custom prompt
PROMPT_THEME=$PROMPTDIR/berrym-default.zsh
if [[ -r $PROMPT_THEME ]]; then
    print - "$fg[yellow] * $fg[magenta] Loading custom prompt."
    print - "$fg[green]    sourcing $PROMPT_THEME $reset_color"
    . $PROMPT_THEME
else
    print - "$fg[red]    Unable to source $PROMPT_THEME $reset_color"
fi

# Display bovine wisdom
command -v cowsay &>/dev/null && command -v fortune &>/dev/null
if [[ $? -eq 0 ]]; then
    cowsay `fortune`
fi
