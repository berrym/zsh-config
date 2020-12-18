# .zshenv - z shell environment config file
#
# (c) 2020 Michael Berry <trismegustis@gmail.com>

# Behave like the z shell/load default options
emulate -L zsh

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

autoload colors
colors

print - "$fg[yellow] * $fg[magenta] Detecting OS to set environment."

if isLinux; then
    print - "$fg[blue]    OS is Linux."
elif isDarwin; then
    print - "$fg[green]    OS is Darwin."
elif isFreeBSD; then
    print - "$fg[green]    OS is FreeBSD."
    path=($path /usr/X11R6/bin)
    hash -d ports=/usr/ports
    hash -d src=/usr/src
elif isOpenBSD; then
    print - "$fg[green]    OS is OpenBSD."
    path=($path /usr/X11R6/bin)
    TERM=xterm-xfree86
    hash -d ports=/usr/ports
    hash -d src=/usr/src
    hash -d xenocara=/usr/xenocara
elif isNetBSD; then
    print - "$fg[green]    OS is NetBSD."
    path=($path /usr/pkg/sbin /usr/pkg/bin /usr/X11R7/bin)
    hash -d pkgsrc=/usr/pkgsrc
fi

print - "$fg[yellow] * $fg[magenta] Setting path:"
for p in $path; do
    print - "$fg[green]    $p$reset_color"
done

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
if command -v tmux &>/dev/null && [[ -z "$TMUX" ]]; then
    tmux attach -t default || tmux new -s default
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
