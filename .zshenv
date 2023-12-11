# .zshenv - z shell environment config file
#
# (c) 2023 Michael Berry <trismegustis@gmail.com>

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
        if [[ -z "SSH_CONNECTION" ]] || [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
            tmux attach -t=remote_tmux || tmux new -s remote_tmux
        else
            tmux attach -t=local_tmux || tmux new -s local_tmux
        fi
    fi
fi

# Set global exports
export LANG CHARSET PATH PAGER EDITOR

HISTSIZE=100
SAVEHIST=100
HISTFILE=$HOME/.zsh_history

ZSH_DIR=$HOME/.zsh
ALIAS_DIR=$ZSH_DIR/aliases
PROMPT_DIR=$ZSH_DIR/prompts
COMPLETERS_DIR=$ZSH_DIR/completers
THIRD_PARTY_DIR=$ZSH_DIR/third-party
LAB_DIR=$HOME/Lab

# Set some programming language environments
[[ -f "$HOME/.ghcup/env" ]] && . "$HOME/.ghcup/env"

[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# pyenv
command -v pyenv &>/dev/null
if [[ $? -eq 0 ]]; then
    eval "$(pyenv virtualenv-init -)"
fi
