# .zshrc - z shell config file
#
# (c) 2020 Michael Berry <trismegustis@gmail.com>

# Load custom scripts
zsh_scripts=(
    ${ZDOTDIR:-$ZSHDIR}/zshopts.zsh  # zsh options
    ${ZDOTDIR:-$ZSHDIR}/zshfuncs.zsh # utility functions
    ${ZDOTDIR:-$ZSHDIR}/aliases.zsh  # aliases
    ${ZDOTDIR:-$ZSHDIR}/prompts.zsh  # prompt functions
    ${ZDOTDIR:-$ZSHDIR}/third-party.zsh # third party functions
)

for f in $zsh_scripts; do
    if [[ -r $f ]]; then
	. $f
    else
	print "Unable to load $f"
    fi
done

# Load custom prompt
PROMPT_THEME=${ZDOTDIR:-$PROMPTDIR}/berrym-default.zsh
if [[ -r $PROMPT_THEME ]]; then
    . $PROMPT_THEME
else
    print "Unable to load prompt theme $PROMPT_THEME"
fi
