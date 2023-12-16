_loadPromptTheme() {
    cd $PROMPT_DIR
    local -a themes=(`ls -1 | sed 's/\.[^.]*$//' | sort -u`)
    compadd -X "%{$fg[cyan]%}completing %Bprompt themes%b%{$reset_color%}" -a themes
    popd
}

compdef -a _loadPromptTheme loadPromptTheme
