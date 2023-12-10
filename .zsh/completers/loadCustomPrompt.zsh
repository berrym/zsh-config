_loadCustomPrompt() {
    cd $PROMPT_DIR
    local -a prompts=(`ls -1 | sed 's/\.[^.]*$//' | sort -u`)
    compadd -X "%{$fg[cyan]%}Custom Themed Prompts%{$reset_color%}" -a prompts
    popd
}

compdef -a _loadCustomPrompt loadCustomPrompt
