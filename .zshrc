# .zshrc - z shell config file
#
# (c) 2020 Michael Berry <trismegustis@gmail.com>

# Behave like the z shell/load default options
emulate -L zsh

# Set pager
command -v less &>/dev/null
if [[ $? -eq 0 ]]; then
    PAGER=less
else
    PAGER=more
fi

# Check for the mg editor, else default to vi
command -v mg &>/dev/null
if [[ $? -eq 0 ]]; then
    EDITOR=mg
else
    EDITOR=vi
fi

# Set global exports
export LANG CHARSET PATH PAGER EDITOR

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

HISTSIZE=100
SAVEHIST=100

ZSHDIR=${ZDOTDIR:-$HOME}/.zsh
ZSH_THIRD_PARTY_DIR=${ZDOTDIR:-$ZSHDIR}/third-party
PROMPTDIR=${ZDOTDIR:-$ZSHDIR}/prompts

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
