# miscfuncs.zsh - z shell miscellaneous functions
#
# (c) 2023 Michael Berry <trismegustis@gmail.com>

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

# Switch to LABDIR root directory or a project subdir, create it if needed
lab() {
    emulate -RL zsh

    if [[ $ARGC -eq 0 ]]; then
        mkcd $LAB_DIR
    elif [[ $ARGC -eq 1 ]]; then
        mkcd $LAB_DIR/$1
    else
        print - 'usage: lab <directory>\n'
        return 1
    fi
}

# Load a custom prompt
loadPromptTheme() {
    emulate -RL zsh

    if [[ ! $ARGC -eq 1 ]]; then
        print - 'usage: loadPromptTheme <prompt-theme>\n'
        return 1
    else
        local prompt_theme=$PROMPT_DIR/$1.zsh
        [[ -r $prompt_theme ]] && . $prompt_theme
    fi
}

# Trim surrounding whitespace in a string
# Works because zsh automatically trims by assigning to variables and by passing arguments
trim() { print - $1; }

# Screen and tmux's behaviour for when multiple clients are attached
# to one session differs slightly. In Screen, each client can be connected
# to the session but view different windows within it, but in tmux,
# all clients connected to one session must view the same window.
# This problem can be solved in tmux by spawning two separate sessions and
# synchronizing the second one to the windows of the first,
# then pointing a second new session to the first.
tmux_screen_spawn() {
    emulate -RL zsh

    if [[ ! $ARGC -eq 1 ]]; then
        print - 'usage: tmux_screen_spawn <session-name>\n'
        return 1
    fi

    base_session="$1"
    # This actually works without the trim() on all systems except OSX
    tmux_nb=$(trim `tmux ls | grep "^$base_session" | wc -l`)
    if [[ "$tmux_nb" == "0" ]]; then
        print - "Launching tmux base session $base_session ..."
        tmux new-session -s $base_session
    else
        # Make sure we are not already in a tmux session
        if [[ -z "$TMUX" ]]; then
            print - "Launching copy of base session $base_session ..."
            # Session id is base session + date and time to prevent conflict
            dt=$(command -p date +"%Y-%m-%d (%H%M%S)")
            session_id="$base_session $dt"
            # Create a new session (without attaching it) and link to base session
            # to share windows
            tmux new-session -d -t $base_session -s $session_id
            if [[ "$2" == "1" ]]; then
                # Create a new window in that session
                tmux new-window
            fi
            # Attach to the new session & kill it once orphaned
            tmux attach-session -t $session_id \; set-option destroy-unattached
        fi
    fi
}

# Add private ssh key to keychain
add_ssh_key_to_keychain() {
    if [[ isLinux ]]; then
        /usr/bin/keychain $HOME/.ssh/id_ed25519
        source $HOME/.keychain/$HOST-sh
    fi
}
