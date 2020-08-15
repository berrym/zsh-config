# .zshrc - z shell config file
#
# (c) 2020 Michael Berry <trismegustis@gmail.com>

# Behave like the z shell/load default options
emulate -L zsh

# Determine OS
# Test if OS is Linux
isLinux() {
    [[ $OSNAME == "Linux" ]]
}

# Test if OS is Darwin
isDarwin() {
    [[ $OSNAME == "Darwin" ]]
}

# Test if OS is FreeBSD
isFreeBSD() {
    [[ $OSNAME == "FreeBSD" ]]
}

# Test if OS is OpenBSD
isOpenBSD() {
    [[ $OSNAME == "OpenBSD" ]]
}

# Test if OS is NetBSD
isNetBSD() {
    [[ $OSNAME == "NetBSD" ]]
}

# Test if OS is DragonFly
isDragonFly() {
    [[ $OSNAME == "DragonFly" ]]
}

# Set path and other OS independent variables
typeset -U path
path=(/usr/local/bin
      /usr/local/sbin
      /usr/bin
      /usr/sbin
      /bin
      /sbin
      ~/.local/bin
      ~/bin
      $path)
LANG=en_US.UTF-8
CHARSET=en_US.UTF-8
OSNAME=$(uname -s)        # Determine OS

if isLinux; then
    ;
elif isDarwin; then
    ;
elif isFreeBSD; then
    path=($path /usr/X11R6/bin)
    hash -d ports=/usr/ports
    hash -d src=/usr/src
elif isOpenBSD; then
    path=($path /usr/X11R6/bin)
    TERM=xterm-xfree86
    hash -d ports=/usr/ports
    hash -d src=/usr/src
    hash -d xenocara=/usr/xenocara
elif isNetBSD; then
    path=($path /usr/pkg/sbin /usr/pkg/bin /usr/X11R7/bin)
    hash -d pkgsrc=/usr/pkgsrc
fi

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

ZSHDIR=${ZDOTDIR:-$HOME}/.zsh

# Load custom scripts
zsh_scripts=(
    ${ZDOTDIR:-$ZSHDIR}/zshopts.zsh  # zsh options
    ${ZDOTDIR:-$ZSHDIR}/zshfuncs.zsh # utility functions
    ${ZDOTDIR:-$ZSHDIR}/aliases.zsh  # aliases
)

for f in $zsh_scripts; do
    . $f
done

# Run the powerline daemon
command -v powerline-daemon &>/dev/null
if [[ $? -eq 0 ]]; then
    powerline-daemon &>/dev/null
fi

PROMPTDIR=${ZDOTDIR:-$ZSHDIR}/prompts

# Load custom prompt
PROMPT_THEME=${ZDOTDIR:-$PROMPTDIR}/berrym-arrows.zsh
source $PROMPT_THEME
