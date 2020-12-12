# zshfuncs.zsh - z shell miscellaneous functions
#
# (c) 2020 Michael Berry <trismegustis@gmail.com>

# Print more information to user if positive
VERBOSE=1
verbose() {
    [[ $VERBOSE -gt 0 ]]
}

# Switch to a directoy and then list it's contents
cl() {
    emulate -RL zsh

    if [[ $ARGC -ne 1 ]]; then
        print - 'usage: cl <directory>'
        return 1;
    fi

    if [[ -d $1 ]]; then
        cd $1 && ls -a
    else
        if verbose; then
            print - "directory \`$1' does not exist.\n"
        fi
    fi
}

# Print a list of modified files
modified () {
    print -l -- *(m-${1:-1})
}

# Switch to directory, create it if necessary
mkcd() {
    emulate -RL zsh

    if [[ $ARGC -ne 1 ]]; then
        print - 'usage: mkcd <new-directory>\n'
        return 1;
    fi

    if [[ ! -d $1 ]]; then
        command mkdir -p $1
        if verbose; then
            printf 'created directory `%s'\'', cd-ing into it.\n' "$1"
        fi
    else
        if verbose; then
            printf '`%s'\'' already exists: cd-ing into directory.\n' "$1"
        fi
    fi

    cd $1
}

# Completion for lab function
_lab() {
    local LABDIR=$HOME/Lab
    cd $LABDIR
    local SUBDIRS=(`ls -Rd */ |  sed '/"-f"/d'`)
    compadd "$@" $SUBDIRS
    popd
}

# Switch to LABDIR root directory or a project subdir, create it if needed
lab() {
    emulate -RL zsh

    local LABDIR=$HOME/Lab

    if [[ $ARGC -eq 0 ]]; then
        mkcd $LABDIR
    elif [[ $ARGC -eq 1 ]]; then
        mkcd $LABDIR/$1
    else
        print - 'usage: lab <directory>\n'
    fi
}

compdef _lab lab
