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
      ~/bin
      ~/go/bin
      ~/.local/bin
      ~/.cargo/bin
      ~/.npm-global/bin
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

if [[ -x "$(command -v less)" ]]; then
    PAGER=less
else
    PAGER=more
fi

# Check for the nvim editor, else default to vi
if [[ -x "$(command -v nvim)" ]]; then
    EDITOR=nvim
else
    if [[ -x "$(command -v vim)" ]]; then
        EDITOR=vim
else
        EDITOR=vi
    fi
fi

# Run the powerline daemon
if [[ -x "$(command -v powerline-daemon)" ]]; then
    powerline-daemon &>/dev/null
fi

# Set global exports
export LANG CHARSET PATH PAGER EDITOR

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history

ZSH_DIR=$HOME/.zsh
ALIAS_DIR=$ZSH_DIR/aliases
PROMPT_DIR=$ZSH_DIR/prompts
COMPLETERS_DIR=$ZSH_DIR/completers
THIRD_PARTY_DIR=$ZSH_DIR/third-party
LAB_DIR=$HOME/Lab

# Set some programming language environments

# ghcup for user local haskell
[[ -f "$HOME/.ghcup/env" ]] && . "$HOME/.ghcup/env"

# cargo for user local rust
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# pyenv for local python management
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d $PYENV_ROOT/bin ]]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    # start pyenv
    if [[ -x "$(command -v pyenv)" ]]; then
        eval "$(pyenv init - zsh)"
    fi
fi

# cpan local perl management
PATH="/home/mberry/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/mberry/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/mberry/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/mberry/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/mberry/perl5"; export PERL_MM_OPT;
