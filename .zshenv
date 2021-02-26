# .zshenv - z shell environment config file
#
# (c) 2020 Michael Berry <trismegustis@gmail.com>

# Behave like the z shell/load zsh options
emulate -L zsh
autoload -Uz colors && colors

# Set path and other OS independent variables
typeset -U path
path=(/usr/local/bin
      /usr/local/sbin
      /usr/bin
      /usr/sbin
      /bin
      /sbin
      ~/.local/bin
      ~/.cargo/bin
      ~/bin
      $path)

LANG=en_US.UTF-8
CHARSET=en_US.UTF-8
OSNAME=$(uname -s)        # Determine OS

# Define some OS tests
isLinux() {
    [[ $OSNAME == "Linux" ]]
}

isDarwin() {
    [[ $OSNAME == "Darwin" ]]
}

isFreeBSD() {
    [[ $OSNAME == "FreeBSD" ]]
}

isOpenBSD() {
    [[ $OSNAME == "OpenBSD" ]]
}

isNetBSD() {
    [[ $OSNAME == "NetBSD" ]]
}

isDragonFly() {
    [[ $OSNAME == "DragonFly" ]]
}


if isLinux; then
    :
elif isDarwin; then
    :
elif isFreeBSD; then
    path=($path /usr/X11R6/bin)
    hash -d ports=/usr/ports
    hash -d src=/usr/src
elif isOpenBSD; then
    path=($path /usr/X11R6/bin)
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

# Check for the nvim editor, else default to vi
command -v nvim &>/dev/null
if [[ $? -eq 0 ]]; then
    EDITOR=nvim
else
    EDITOR=vi
fi

# Run the powerline daemon
command -v powerline-daemon &>/dev/null
if [[ $? -eq 0 ]]; then
    powerline-daemon &>/dev/null
fi

# Run tmux
command -v tmux &>/dev/null
if [[ $? -eq 0 ]]; then
    if [[ -z "$TMUX" ]]; then
        tmux -2 attach -t default || tmux -2 new -s default
    fi
fi

# Set global exports
export LANG CHARSET PATH PAGER EDITOR

HISTSIZE=100
SAVEHIST=100
HISTFILE=$HOME/.zsh_history

ZSHDIR=$HOME/.zsh
ALIASDIR=$ZSHDIR/aliases
PROMPTDIR=$ZSHDIR/prompts
ZSH_THIRD_PARTY_DIR=$ZSHDIR/third-party
source "$HOME/.cargo/env"
