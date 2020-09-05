# .zshrc - z shell config file
#
# (c) 2020 Michael Berry <trismegustis@gmail.com>

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
    else
        print "Unable to load $f"
    fi
done

# Display bovine wisdom
command -v cowsay &>/dev/null && command -v fortune &>/dev/null
if [[ $? -eq 0 ]]; then
    cowsay -f stegosaurus `fortune`
fi

# Run the powerline daemon
command -v powerline-daemon &>/dev/null
if [[ $? -eq 0 ]]; then
    powerline-daemon &>/dev/null
fi

# Load custom prompt
PROMPT_THEME=$PROMPTDIR/berrym-default.zsh
if [[ -r $PROMPT_THEME ]]; then
    . $PROMPT_THEME
else
    print "Unable to load prompt theme $PROMPT_THEME"
fi
