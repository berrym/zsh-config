# .zshrc - z shell config file
#
# (c) 2018 Michael Berry <trismegustis@gmail.com>

# Behave like the z shell
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
      ~/bin
      $path)
LANG=en_US.UTF-8
CHARSET=en_US.UTF-8
OSNAME=$(uname -s)        # Determine OS

if isLinux; then
    ;
elif isDarwin; then
    path=($path /usr/x11/bin)
    # HomeBrew GitHub Key
    export HOMEBREW_GITHUB_API_TOKEN=60f48f8a8684dcd786edd0011cb61b39fd7aacb6
    export HOMEBREW_CC=clang
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

# Custom zsh scripts directory
ZSH_DIR=~/.zsh

# Set global exports
export LANG CHARSET PATH PAGER EDITOR ZSH_DIR

# Load zsh options
if [[ -r ~/${ZSH_DIR}/.zshopts.zsh ]]; then
    . ~/${ZSH_DIR}/.zshopts.zsh
fi

# Load custom utility functions
if [[ -r ~/${ZSH_DIR}/.zshfuncs.zsh ]]; then
    . ~/${ZSH_DIR}/.zshfuncs.zsh
fi

# Load aliases
if [[ -r ~/${ZSH_DIR}/.aliases.zsh ]]; then
    . ~/${ZSH_DIR}/.aliasrc
fi
